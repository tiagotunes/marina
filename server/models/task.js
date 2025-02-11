const { Schema, model } = require("mongoose");

const taskSchema = Schema({
  userId: { type: Schema.Types.ObjectId, required: true, ref: "User" },
  read: { type: Boolean, default: false },
  dtDeadline: { type: Date, required: true },
  status: { type: String, required: true },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

exports.Task = model("Task", taskSchema);
