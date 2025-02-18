const { Schema, model } = require("mongoose");

const taskSchema = Schema({
  docId: { type: Schema.Types.ObjectId, required: true, ref: "Document" },
  userId: { type: Schema.Types.ObjectId, required: true, ref: "User" },
  read: { type: Boolean, default: false },
  dtDeadline: {
    type: Date,
    required: true,
    default: Date.now() + 7 * 24 * 60 * 60 * 1000,
  },
  score: { type: Number, default: 0.0 },
  measures: [{ type: Schema.Types.ObjectId, ref: "Measure" }],
  // nMeasures: { type: Number, default: 0 },
  status: { type: String, required: true },
  comment: String,
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

// PRE-save hook
taskSchema.pre("save", async function (next) {
  if (this.measures.length > 0) {
    // await this.popupate("measures");
    // const totalScore = this.measures.reduce(
    //   (acc, measure) => acc + measure.value,
    //   0
    // );
    // this.score = totalScore / this.measures.length;
    // this.score = parseFloat((totalScore / this.measures.length).toFixed(1));
  }
  next();
});

taskSchema.set("toObject", { virtuals: true });
taskSchema.set("toJson", { virtuals: true });

exports.Task = model("Task", taskSchema);
