const { User } = require("../../models/user");

/*------------------------------------------------------------------------
  GET 
  /admin/users
------------------------------------------------------------------------*/
exports.getAllUsers = async function (_, res) {
  try {
    const users = await User.find().populate({
      path: "domains",
      select: "name",
    });
    if (!users) {
      return res.status(404).json({ message: "Users not found" });
    }
    return res.json(users);
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  GET 
  /admin/users/count
------------------------------------------------------------------------*/
exports.getUsersCount = async function (_, res) {
  try {
    const userCount = await User.countDocuments();
    if (!userCount) {
      return res.status(500).json({ message: "Could not count users" });
    }
    return res.json({ userCount });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  PUT 
  /admin/users/:id
------------------------------------------------------------------------*/
exports.editUser = async function (req, res) {
  try {
    const user = await User.findByIdAndUpdate(
      req.params.id,
      { ...req.body, dtUp: Date.now() },
      { new: true, runValidators: true }
    );
    if (!user) return res.status(404).json({ message: "User not found" });

    return res.status(200).json(user);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  DELETE 
  /admin/users/:id
------------------------------------------------------------------------*/
exports.deleteUser = async function (req, res) {
  try {
    const userId = req.params.id;

    const deletedUser = await User.findOneAndDelete({ _id: userId });
    if (!deletedUser)
      return res.status(404).json({ message: "User not found" });

    res.status(204).end();
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
