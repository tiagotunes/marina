const { Schema, model } = require("mongoose");

const measureTypeSchema = Schema({
  name: { type: String, required: true, trim: true },
  text: { type: String, required: true, trim: true },
  status: {
    type: String,
    required: true,
    enum: ["active", "inactive", "delete"],
  },
  dtStatus: { type: Date, default: Date.now() },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

measureTypeSchema.index({ name: 1 }, { unique: true });

measureTypeSchema.set("toObject", { virtuals: true });
measureTypeSchema.set("toJson", { virtuals: true });

exports.MeasureType = model("MeasureType", measureTypeSchema);
