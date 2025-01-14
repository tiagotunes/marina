const { User } = require("../models/user");

exports.getUsers = async (_, res) => {
  try {
    const users = await User.find().select("name email id admin");
    if (!users) {
      return res.status(404).json({ message: "Users not found" });
    }
    return res.json(users);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.getUserById = async (req, res) => {
  try {
    const user = await User.findById(req.params.id).select(
      "-passwordHash -resetPasswordOtp -dtResetPasswordOtp"
    );
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    return res.json(user);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.updateUser = async (req, res) => {
  try {
    const { name, email, gender } = req.body;
    const user = await User.findByIdAndUpdate(
      req.params.id,
      {
        name,
        email,
        gender,
      },
      { new: true }
    );

    if (!user) {
      return res.status(404).json({ message: "Users not found" });
    }
    user.passwordHash = undefined;
    return res.json(user);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
