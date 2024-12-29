const { Schema, model } = require("mongoose");

const tokenSchema = Schema({
  userId: { type: Schema.Types.ObjectId, required: true, ref: "User" },
  refreshToken: { type: String, required: true },
  accessToken: String,
  dtCr: { type: Date, default: Date.now(), expires: 60 * 86400 },
  dtUp: Date,
});

exports.Token = model("Token", tokenSchema);
