const { Schema, model } = require("mongoose");

const measureTypeSchema = Schema({
  name: { type: String, required: true, trim: true },
  text: { type: String, required: true, trim: true },
  status: { type: String, required: true },
  dtStatus: { type: Date, default: Date.now() },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

measureTypeSchema.index({ name: 1 }, { unique: true });

measureTypeSchema.set("toObject", { virtuals: true });
measureTypeSchema.set("toJson", { virtuals: true });

exports.Measure = model("MeasureType", measureTypeSchema);
