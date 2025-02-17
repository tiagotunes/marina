const { Domain } = require("../../models/domain");

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
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
