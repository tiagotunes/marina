const cron = require("node-cron");
const { Domain } = require("../models/domain");
const { Document } = require("../models/document");
const { User } = require("../models/user");
const { Task } = require("../models/task");
const { MeasureType } = require("../models/measure_type");
const { Measure } = require("../models/measure");

// "minute hour dayOfMonth month dayOfWeek"

cron.schedule("0 0 * * *", async function () {
  try {
    console.log("[UPDATE_DOMAINS] Running at ", new Date());

    let domainsToBeUpdated = await Domain.find({
      status: { $ne: "$plannedStatus" },
    });

    if (domainsToBeUpdated.length !== 0) {
      // Prepare bulk update operations and execution
      const bulkDomainOps = domainsToBeUpdated.map((domain) => ({
        updateOne: {
          filter: { _id: domain._id },
          update: { status: domain.plannedStatus, dtStatus: Date.now() },
        },
      }));
      await Domain.bulkWrite(bulkDomainOps);

      // Get all inactive domain IDs
      const inactiveDomainIds = domainsToBeUpdated
        .filter((d) => d.plannedStatus === "inactive")
        .map((d) => d._id);

      if (inactiveDomainIds.length > 0) {
        const updateResult = await Document.updateMany(
          { domainId: { $in: inactiveDomainIds } },
          { status: "close" }
        );
      }
      console.log(
        `[UPDATE_DOMAINS] Running at ${new Date()}, Closed ${
          updateResult.modifiedCount
        } documents`
      );
    }

    console.log(
      `[UPDATE_DOMAINS] Completed at ${new Date()}, Updated ${
        domainsToBeUpdated.length
      } domains`
    );
  } catch (error) {
    console.error("[UPDATE_DOMAINS] Error: ", error);
  }
});

cron.schedule("0 0 * * *", async function () {
  try {
    console.log("[CREATE_TASKS] Running at ", new Date());

    const docs = await Document.find({ status: "open" });
    const users = await User.find({ status: "active", admin: false });
    const measureTypes = await MeasureType.find({ status: "active" });

    if (!docs || !users || !measureTypes) {
      console.log("[CREATE_TASKS] No new tasks to create");
      return;
    }

    const tasksToInsert = [];
    const measuresToInsert = [];

    for (const doc of docs) {
      for (const user of users) {
        const existingTask = await Task.findOne({
          docId: doc.id,
          userId: user.id,
        });
        if (!existingTask) {
          const taskId = new Task()._id;

          // Create measures associated with this task
          const measures = measureTypes.map((mType) => ({
            measureTypeId: mType._id,
            taskId: taskId,
          }));
          measuresToInsert.push(...measures);

          // Create new Task
          tasksToInsert.push({
            _id: taskId,
            docId: doc.id,
            userId: user.id,
            dtDeadline: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
            status: "I",
            measures: measures.map((m) => m._id),
          });
        }
      }
    }

    // Insert measures and tasks
    if (measuresToInsert.length) {
      const insertedMeasures = await Measure.insertMany(measuresToInsert);
      const measureMap = new Map(
        insertedMeasures.map((m) => [m.taskId.toString(), m._id])
      );

      // Assign the correct measure IDs to tasks
      tasksToInsert.forEach((task) => {
        task.measures = measureMap.get(task._id.toString()) || [];
      });
    }

    if (tasksToInsert.length) {
      await Task.insertMany(tasksToInsert);
    }

    console.log(
      `[CREATE_TASKS] Completed at ${new Date()}, Created ${
        tasksToInsert.length
      } tasks`
    );
  } catch (error) {
    console.error("[CREATE_TASKS] Error: ", error);
  }
});
