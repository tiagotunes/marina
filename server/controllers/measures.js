const { default: mongoose } = require("mongoose");
const jwt = require("jsonwebtoken");
const { Task } = require("../models/task");
const { Measure } = require("../models/measure");
const { MeasureType } = require("../models/measure_type");

/*------------------------------------------------------------------------
  GET 
  /tasks/:id
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
