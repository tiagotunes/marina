const { User } = require("../models/user");
const { Token } = require("../models/token");

exports.getUserCount = async function (req, res) {
  try {
    const userCount = await User.countDocuments();
    if (!userCount) {
      return res.status(500).json({ message: "Could not count users." });
    }
    return res.json({ userCount });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.deleteUser = async function (req, res) {
  try {
    const userId = req.params.id;

    const user = await User.findById(userId);
    if (!user) return res.status(404).json({ message: "User not found!" });

    await Token.deleteOne({ userId: userId });
    await User.deleteOne({ _id: userId });

    return res.status(204).end();
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
