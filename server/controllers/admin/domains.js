const { Domain } = require("../../models/domain");

/*------------------------------------------------------------------------
  GET 
  /admin/domains
------------------------------------------------------------------------*/
exports.getAllDomains = async function (_, res) {
  try {
    let domains = await Domain.find();
    if (!domains) return res.status(404).json({ message: "Domains not found" });
    return res.json(domains);
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  POST 
  /admin/domains
------------------------------------------------------------------------*/
exports.addDomain = async function (req, res) {
  try {
    const { name, status } = req.body;

    let domain = new Domain({
      name: name.trim(),
      status: status.trim(),
      plannedStatus: status.trim(),
    });
    domain = await domain.save();
    if (!domain) {
      return res
        .status(500)
        .json({ message: "The domain could not be created" });
    }
    res.status(201).json(domain);
  } catch (error) {
    if (error.message.includes("name_1 dup key")) {
      res.status(409).json({
        type: "IndexError",
        message: "Domain with that name already exists",
      });
    }
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  PUT 
  /admin/domains/:id
------------------------------------------------------------------------*/
exports.editDomain = async function (req, res) {
  try {
    const updateFields = { ...req.body, dtUp: Date.now() };
    if (req.body.plannedStatus != null) {
      updateFields.dtStatus = Date.now();
    }

    const domain = await Domain.findByIdAndUpdate(req.params.id, updateFields, {
      new: true,
      runValidators: true,
    });
    if (!domain) {
      return res.status(404).json({ message: "Domain not found" });
    }

    return res.json(domain);
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  DELETE 
  /admin/domains/:id
------------------------------------------------------------------------*/
exports.deleteDomain = async function (req, res) {
  try {
    const domain = await Domain.findOneAndDelete({ _id: req.params.id });
    if (!domain) {
      return res.status(404).json({ message: "Domain not found" });
    }
    return res.status(204).end();
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
