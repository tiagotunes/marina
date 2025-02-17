const { Schema, model } = require("mongoose");

const measureSchema = Schema({
  measureTypeId: {
    type: Schema.Types.ObjectId,
    required: true,
    ref: "MeasureType",
  },
  taskId: {
    type: Schema.Types.ObjectId,
    required: true,
    ref: "Task",
  },
  value: { type: Number, required: true },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

measureSchema.set("toObject", { virtuals: true });
measureSchema.set("toJson", { virtuals: true });

exports.TaskMeasure = model("Measure", measureSchema);
