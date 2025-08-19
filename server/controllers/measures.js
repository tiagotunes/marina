const { default: mongoose } = require("mongoose");
const jwt = require("jsonwebtoken");
const { Task } = require("../models/task");
const { Measure } = require("../models/measure");

/*------------------------------------------------------------------------
  GET 
  /tasks/:id/measures
------------------------------------------------------------------------*/
exports.getMeasures = async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const pageSize = 10;

    const task = await Task.findById(req.params.id);
    if (!task) return res.status(404).json({ message: "Task not found" });

    const measures = await Measure.find({ _id: { $in: task.measures } })
      .sort({ dtUp: -1, dt_Cr: -1 })
      .skip((page - 1) * pageSize)
      .limit(pageSize);

    if (!measures.length)
      return res.status(404).json({ message: "No measures found" });

    return res.json(measures);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
