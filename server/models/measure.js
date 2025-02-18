const { Schema, model } = require("mongoose");

const measureSchema = Schema({
  measureTypeId: {
    type: Schema.Types.ObjectId,
    required: true,
    ref: "MeasureType",
  },
  value: { type: Number, default: 0, required: true },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

measureSchema.set("toObject", { virtuals: true });
measureSchema.set("toJson", { virtuals: true });

exports.Measure = model("Measure", measureSchema);
