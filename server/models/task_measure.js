const { Schema, model } = require("mongoose");

const taskMeasureSchema = Schema({
  taskId: { type: Schema.Types.ObjectId, required: true, ref: "Task" },
  measureId: { type: Schema.Types.ObjectId, required: true, ref: "Measure" },
  value: { type: Number, required: true },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

taskMeasureSchema.index({ taskId: 1, measureId: 1 }, { unique: true });

exports.TaskMeasure = model("TaskMeasure", taskMeasureSchema);
