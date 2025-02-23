const { Schema, model } = require("mongoose");
const { Token } = require("../models/token");
const { Task } = require("../models/task");
const { Measure } = require("../models/measure");

const userSchema = Schema({
  name: { type: String, required: true, trim: true },
  email: { type: String, required: true, trim: true },
  passwordHash: { type: String, required: true },
  resetPasswordOtp: Number,
  dtResetPasswordOtp: Date,
  gender: { type: String, enum: ["undefine", "female", "male"] },
  domains: [{ type: Schema.Types.ObjectId, ref: "Domain" }],
  status: {
    type: String,
    required: true,
    enum: ["active", "inactive", "delete"],
  },
  admin: { type: Boolean, default: false },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

userSchema.index({ email: 1 }, { unique: true });

/*------------------------------------------------------------------------
  PRE HOOKS - Delete tasks and mesaures related to the user
------------------------------------------------------------------------*/
userSchema.pre("findOneAndDelete", async function (next) {
  const user = await this.model.findOne(this.getFilter());
  if (!user) return next();

  // Delete user token
  await Token.deleteOne({ userId: user._id });

  // Find all tasks assigned to the user
  const tasks = await Task.find({ userId: user._id });
  // console.log(tasks);

  // Extract all measure IDs from the tasks
  const measureIds = tasks.flatMap((task) => task.measures);
  // console.log(measureIds);

  // Delete all measures associated with the tasks -- NOT TESTED
  await Measure.deleteMany({ _id: { $in: measureIds } });

  // Delete all tasks assigned to the user -- NOT TESTED
  await Task.deleteMany({ userId: user._id });

  next();
});
/*------------------------------------------------------------------------
------------------------------------------------------------------------*/

userSchema.set("toObject", { virtuals: true });
userSchema.set("toJson", { virtuals: true });

exports.User = model("User", userSchema);
