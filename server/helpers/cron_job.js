const cron = require("node-cron");
const { Domain } = require("../models/domain");
const { Document } = require("../models/document");

// "minute hour dayOfMonth month dayOfWeek"
cron.schedule("9 17 * * *", async function () {
  try {
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
    console.log("CRON job completed at ", new Date());
  } catch (error) {
    console.error("CRON job error: ", error);
  }
});
