const { Task } = require("../../models/task");
const { Measure } = require("../../models/measure");
const { MeasureType } = require("../../models/measure_type");
const { default: mongoose } = require("mongoose");

/*------------------------------------------------------------------------
  POST 
  /tasks/:id/measures
------------------------------------------------------------------------*/
exports.addMeasure = async function (req, res) {
  try {
    let task = await Task.findById(req.params.id);
    if (!task) return res.status(404).json({ message: "Task not found" });

    const measureType = await MeasureType.findById(req.body.measureTypeId);
    if (!measureType)
      return res.status(404).json({ message: "Measure Type not found" });

    const measureAlreadyExists = task.measures.find((measure) =>
      measure.measureType._id.equals(
        mongoose.Schema.Types.ObjectId(measureType)
      )
    );
    if (measureAlreadyExists)
      return res
        .status(409)
        .json({ message: "Measure already exists in task" });

    const measure = await new Measure({
      measureTypeId: measureType._id,
    }).save();
    if (!measure) {
      return res.status(500).json({ message: "Measure could not be created" });
    }

    task.measures.push(measure.id);
    task = await task.save();

    return res.status(201).json({ task, measure });
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  DELETE 
  /tasks/:id/measures/:measureId
------------------------------------------------------------------------*/
exports.deleteMeasure = async function (req, res) {
  try {
    let task = await Task.findById(req.params.id);
    if (!task) return res.status(404).json({ message: "Task not found" });

    // TBD
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
