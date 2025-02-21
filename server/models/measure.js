const { Schema, model } = require("mongoose");

const measureSchema = Schema({
  measureTypeId: {
    type: Schema.Types.ObjectId,
    required: true,
    ref: "MeasureType",
  },
  value: { type: Number, required: true, default: 0, max: 5 },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

measureSchema.set("toObject", { virtuals: true });
measureSchema.set("toJson", { virtuals: true });

exports.Measure = model("Measure", measureSchema);
