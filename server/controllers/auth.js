const { validationResult } = require("express-validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { User } = require("../models/user");
const { Token } = require("../models/token");
const mailSender = require("../helpers/email_sender");

exports.register = async function (req, res) {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMsg = errors.array().map((e) => ({
      field: e.path,
      message: e.msg,
    }));
    return res.status(400).json({ errors: errorMsg });
  }
  try {
    let user = new User({
      ...req.body,
      passwordHash: bcrypt.hashSync(req.body.password, 8),
    });

    user = await user.save();

    if (!user) {
      return res.status(500).json({
        type: "Internal Server Error",
        message: "Could not create a new user",
      });
    }

    return res.status(201).json(user);
  } catch (error) {
    if (error.message.includes("email_1 dup key")) {
      res.status(409).json({
        type: "AuthError",
        message: "User with that email already exists",
      });
    }
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.login = async function (req, res) {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
      return res
        .status(404)
        .json({ message: "User not found\nCheck your email and try again." });
    }
    if (!bcrypt.compareSync(password, user.passwordHash)) {
      return res.status(400).json({ message: "Incorrect password!" });
    }

    const accessToken = jwt.sign(
      { id: user.id, admin: user.admin },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: "24h" }
    );
    const refreshToken = jwt.sign(
      { id: user.id, admin: user.admin },
      process.env.REFRESH_TOKEN_SECRET,
      { expiresIn: "60d" }
    );

    const token = await Token.findOne({ userId: user.id });
    if (token) await token.deleteOne();
    await new Token({ userId: user.id, accessToken, refreshToken }).save();

    user.passwordHash = undefined;
    return res.json({ ...user._doc, accessToken });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.verifyToken = async function (req, res) {
  try {
    let accessToken = req.headers.authorization;
    if (!accessToken) return res.json(false);
    accessToken = accessToken.replace("Bearer", "").trim();

    const token = await Token.findOne({ accessToken });
    if (!token) return res.json(false);

    const tokenData = jwt.decode(token.refreshToken);

    const user = await User.findById(tokenData.id);
    if (!user) return res.json(false);

    const isValid = jwt.verify(
      token.refreshToken,
      process.env.REFRESH_TOKEN_SECRET
    );
    if (!isValid) return res.json(false);

    return res.json(true);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.forgotPassword = async function (req, res) {
  try {
    const { email } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
      return res
        .status(404)
        .json({ message: "User with that email does not exist!" });
    }

    const otp = Math.floor(1000 + Math.random() * 9000);

    user.resetPasswordOtp = otp;
    user.dtResetPasswordOtp = Date.now() + 600000;

    await user.save();

    const response = await mailSender.sendMail(
      email,
      "Password Reset OTP",
      `Your OTP for password is: ${otp}`
    );
    return res.json({ message: response });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.verifyPasswordResetOTP = async function (req, res) {
  try {
    const { email, otp } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found!" });
    }
    if (
      user.resetPasswordOtp !== +otp ||
      Date.now() > user.dtResetPasswordOtp
    ) {
      return res.status(401).json({ message: "Invalid or expired OTP" });
    }
    user.resetPasswordOtp = 1;
    user.dtResetPasswordOtp = undefined;

    await user.save();
    return res.json({ message: "OPT confirmed successfully" });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.resetPassword = async function (req, res) {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMsg = errors.array().map((e) => ({
      field: e.path,
      message: e.msg,
    }));
    return res.status(400).json({ errors: errorMsg });
  }
  try {
    const { email, newPassword } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found!" });
    }

    if (user.resetPasswordOtp !== 1) {
      return res
        .status(401)
        .json({ message: "Confirm OTP before resetting password" });
    }

    user.passwordHash = bcrypt.hashSync(newPassword, 8);
    user.resetPasswordOtp = undefined;
    await user.save();

    return res.json({ message: "Password reset successfully" });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
