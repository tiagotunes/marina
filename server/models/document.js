const { Schema, model } = require("mongoose");

const documentSchema = Schema({
  domainId: { type: Schema.Types.ObjectId, required: true, ref: "Domain" },
  title: { type: String, required: true, trim: true },
  text: { type: String, required: true, trim: true },
  tasks: [{ type: Schema.Types.ObjectId, ref: "Task" }],
  status: { type: String, required: true },
  dtStatus: { type: Date, default: Date.now() },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

documentSchema.index({ title: "text", text: "text" });

documentSchema.set("toObject", { virtuals: true });
documentSchema.set("toJson", { virtuals: true });

exports.Document = model("Document", documentSchema);
