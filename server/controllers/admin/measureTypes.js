const { MeasureType } = require("../../models/measure_type");

exports.getMTypes = async function (req, res) {
  try {
    const mts = await MeasureType.find({ status: "A" }).sort({ dtStatus: -1 });
    if (!mts)
      return res.status(404).json({ message: "Measure types not found" });
    return res.json(mts);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.getMTCounts = async function (req, res) {};

exports.addMType = async function (req, res) {
  try {
    let mt = new MeasureType({
      name: req.body.name,
      text: req.body.text,
      status: req.body.status,
    });
    mt = await mt.save();
    if (!mt) {
      return res
        .status(500)
        .json({ message: "The measure type could not be created" });
    }
    res.status(201).json(mt);
  } catch (error) {
    if (error.message.includes("name_1 dup key")) {
      return res.status(409).json({
        type: "IndexError",
        message: "Measure type with that name already exists",
      });
    }
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
