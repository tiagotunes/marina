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
    console.log("[UPDATE_DOMAINS] running   ", new Date());

    let domainsToBeUpdated = await Domain.find();
    domainsToBeUpdated = domainsToBeUpdated.filter(
      (domain) => domain.status != domain.plannedStatus
    );

    for (const domain of domainsToBeUpdated) {
      const domainDocumentsCount = await Document.countDocuments({
        domainId: domain.id,
      });
      if (domainDocumentsCount < 1) {
        domain.status = domain.plannedStatus;
        domain.save();
      }
    }
    console.log("[UPDATE_DOMAINS] completed ", new Date());
  } catch (error) {
    console.error("[UPDATE_DOMAINS] error     ", error);
  }
});

cron.schedule("21 18 * * *", async function () {
  try {
    console.log("[CREATE_TASKS]   running   ", new Date());

    const docs = await Document.find({ status: "O" });
    const users = await User.find({ admin: false });

    for (const d of docs) {
      for (const u of users) {
        const existingTask = await Task.findOne({ docId: d.id, userId: u.id });
        if (!existingTask) {
          let task = new Task({
            docId: d.id,
            userId: u.id,
            dtDeadline: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
            status: "I",
          });

          const mts = await MeasureType.find({ status: "A" });
          for (const m of mts) {
            let measure = new Measure({ measureTypeId: m.id });
            measure = await measure.save();
            task.measures.push(measure);
            task = await task.save();
          }
        }
      }
    }
    console.log("[CREATE_TASKS]   completed ", new Date());
  } catch (error) {
    console.error("[CREATE_TASKS]   error     ", error);
  }
});
