const { default: mongoose } = require("mongoose");
const jwt = require("jsonwebtoken");
const { Task } = require("../models/task");
const { Measure } = require("../models/measure");

/*------------------------------------------------------------------------
  GET 
  /tasks/:id/measures
------------------------------------------------------------------------*/
exports.getMeasures = async function (req, res) {
  try {
    const page = req.query.page || 1;
    const pageSize = 10;

    const task = await Task.findById(req.params.id);
    if (!task) return res.status(404).json({ message: "Task not found" });

    const measures = Measure.find({ _id: { $in: task.measures } })
      .sort({ dtUp: -1, dt_Cr: -1 })
      .skip((page - 1) * pageSize)
      .limit(pageSize);
    if (!measures)
      return res.status(404).json({ message: "Measures not found" });

    return res.json(measures);
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  PUT 
  /tasks/:id/measures/:measureId
------------------------------------------------------------------------*/
exports.editMeasure = async function (req, res) {
  try {
    let task = await Task.findById(req.params.id);
    if (!task) return res.status(404).json({ message: "Task not found" });

    let measure = await Measure.findByIdAndUpdate(
      req.params.measureId,
      { value: req.body.value, dtU: Date.now() },
      { new: true, runValidators: true }
    );
    if (!measure) return res.status(404).json({ message: "Measure not found" });

    task = await task.save();

    return res.status(201).json({ task, measure });
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
