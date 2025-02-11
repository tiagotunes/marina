const { Schema, model } = require("mongoose");

const measureSchema = Schema({
  text: { type: String, required: true, trim: true },
  status: { type: String, required: true },
  dtStatus: { type: Date, default: Date.now() },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

measureSchema.index({ text: 1 }, { unique: true });

exports.Measure = model("Measure", measureSchema);
