const { Schema, model } = require("mongoose");

const userSchema = Schema({
  name: { type: String, required: true, trim: true },
  email: { type: String, required: true, trim: true },
  passwordHash: { type: String, required: true },
  resetPasswordOtp: Number,
  dtResetPasswordOtp: Date,
  gender: String,
  role: String,
  admin: { type: Boolean, default: false },
  dtCr: { type: Date, default: Date.now() },
  dtUp: Date,
});

userSchema.index({ email: 1 }, { unique: true });

exports.User = model("User", userSchema);
