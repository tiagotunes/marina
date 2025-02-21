const { Domain } = require("../models/domain");

/*------------------------------------------------------------------------
  GET 
  /domains
------------------------------------------------------------------------*/
exports.getDomains = async function (_, res) {
  try {
    let domains = await Domain.find({ status: "active" });
    if (!domains) return res.status(404).json({ message: "Domains not found" });
    return res.json(domains);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  GET 
  /domains/:id
------------------------------------------------------------------------*/
exports.getDomainById = async function (req, res) {
  try {
    let domain = await Domain.findById(req.params.id);
    if (!domain) return res.status(404).json({ message: "Domain not found" });
    return res.json(domain);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
