const cron = require("node-cron");
const { default: mongoose } = require("mongoose");
const { Domain } = require("../models/domain");
const { Document } = require("../models/document");
const { User } = require("../models/user");
const { Task } = require("../models/task");
const { MeasureType } = require("../models/measure_type");
const { Measure } = require("../models/measure");

function getDate() {
  return new Date().toString().split(" GMT")[0];
}

/**---------------------------------------------------------------------------------
 * * Setting up cron job schedules.
 * cron.schedule("<minute> <hour> <dayOfMonth> <month> <dayOfWeek>", () => ())
 ---------------------------------------------------------------------------------**/
cron.schedule("0 21 * * *", () => updateDomains());
cron.schedule("0 22 * * *", () => createTasks());

/**---------------------------------------------------------------------------------
 * * Updates domain status and closes associated documents based on certain conditions.
 ---------------------------------------------------------------------------------**/
async function updateDomains() {
  try {
    console.log(`[UPDATE_DOMAINS] ${getDate()} Running`);

    const domainsToBeUpdated = await Domain.find({
      $expr: { $ne: ["$status", "$plannedStatus"] },
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

        console.log(
          `[UPDATE_DOMAINS] ${getDate()} Closed ${
            updateResult.modifiedCount
          } documents`
        );
      }
    }

    console.log(
      `[UPDATE_DOMAINS] ${getDate()} ${
        domainsToBeUpdated.length
      } domains updated`
    );

    console.log(`[UPDATE_DOMAINS] ${getDate()} Finish`);
  } catch (error) {
    console.error(`[UPDATE_DOMAINS] ${getDate()} ERROR: ${error}`);
  }
}

/**---------------------------------------------------------------------------------
 * * Generates tasks for active users based on open documents and active measure types.
 ---------------------------------------------------------------------------------*/
async function createTasks(userId = null) {
  try {
    if (!userId) console.log(`[CREATE_TASKS] ${getDate()} Running`);

    const [docs, measureTypes] = await Promise.all([
      Document.find({ status: "open" }),
      MeasureType.find({ status: "active" }),
    ]);

    if (!docs.length) {
      if (!userId)
        console.log(`[CREATE_TASKS] ${getDate()} No documents available`);
      return false;
    }
    if (!measureTypes.length) {
      if (!userId)
        console.log(`[CREATE_TASKS] ${getDate()} No measure types available`);
      return false;
    }

    const users = userId
      ? [await User.findOne({ _id: userId, status: "active", admin: false })]
      : await User.find({ status: "active", admin: false });

    if (!users.length || !users[0]) {
      if (!userId)
        console.log(
          `[CREATE_TASKS] ${getDate()} No valid users found for userId: ${userId}`
        );
      return false;
    }

    const measuresToInsert = measureTypes.map((mType) => ({
      measureTypeId: mType._id,
    }));

    let taskCount = 0;

    for (const doc of docs) {
      for (const user of users) {
        const existingTask = await Task.findOne({
          docId: doc._id,
          userId: user._id,
        });
        if (existingTask) continue;

        const insertedMeasures = await Measure.insertMany(measuresToInsert);

        const task = await new Task({
          docId: doc._id,
          userId: user._id,
          measures: insertedMeasures,
          status: "input",
        }).save();
        if (!task) {
          if (!userId)
            console.error(
              `[CREATE_TASKS] ${getDate()} ERROR: Could not create Task ${
                doc._id
              } ${user._id}`
            );
          return false;
        }
        if (!userId)
          console.log(
            `[CREATE_TASKS] ${getDate()} Created Task ${task._id} with ${
              measuresToInsert.length
            } measures`
          );
        taskCount++;
      }
    }

    if (!userId) {
      console.log(`[CREATE_TASKS] ${getDate()} ${taskCount} tasks created`);
      console.log(`[CREATE_TASKS] ${getDate()} Finish`);
    }
    return true;
  } catch (error) {
    if (!userId) console.error(`[CREATE_TASKS] ${getDate()} ERROR: ${error}`);
    return false;
  }
}

module.exports = { createTasks };
