const { MeasureType } = require("../../models/measure_type");

/*------------------------------------------------------------------------
  GET 
  /measureTypes
------------------------------------------------------------------------*/
exports.getMeasureTypes = async function (_, res) {
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

/*------------------------------------------------------------------------
  GET 
  /measureTypes/count
------------------------------------------------------------------------*/
exports.getMeasureTypesCounts = async function (_, res) {
  try {
    const mtCount = await MeasureType.countDocuments();
    if (!mtCount) {
      return res.status(500).json({ message: "Could not count measure types" });
    }
    return res.json(mtCount);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  POST 
  /measureTypes
------------------------------------------------------------------------*/
exports.addMeasureType = async function (req, res) {
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
