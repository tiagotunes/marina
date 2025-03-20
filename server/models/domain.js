const { Schema, model } = require("mongoose");

const domainSchema = Schema({
  name: { type: String, required: true, trim: true },
  status: {
    type: String,
    required: true,
    enum: ["active", "inactive"],
  },
  plannedStatus: {
    type: String,
    required: true,
    enum: ["active", "inactive"],
  },
  dtStatus: { type: Date, default: Date.now() },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

domainSchema.index({ name: 1 }, { unique: true });

domainSchema.set("toObject", { virtuals: true });
domainSchema.set("toJson", { virtuals: true });

exports.Domain = model("Domain", domainSchema);
