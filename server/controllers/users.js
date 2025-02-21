const { User } = require("../models/user");
const { Task } = require("../models/task");

/*------------------------------------------------------------------------
  GET 
  /users
------------------------------------------------------------------------*/
exports.getUsers = async (_, res) => {
  try {
    const users = await User.find({ status: "active", admin: false }).select(
      "name email gender domains status"
    );
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
  /users/:id
------------------------------------------------------------------------*/
exports.getUserById = async (req, res) => {
  try {
    const user = await User.findById(req.params.id).select(
      "-passwordHash -resetPasswordOtp -dtResetPasswordOtp -dtCr -dtUp"
    );

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    return res.json(user);
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  GET 
  /users/:id/tasks
------------------------------------------------------------------------*/
exports.getUserTaks = async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const tasks = await Task.find({ userId: user._id })
      .select("docId read dtDeadline status")
      .populate({ path: docId, select: "title" })
      .sort({ dtDeadline: -1 });
    if (!tasks) {
      return res.status(404).json({ message: "Tasks not found" });
    }

    return res.json(tasks);
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  PUT 
  /users/:id
------------------------------------------------------------------------*/
exports.editUser = async (req, res) => {
  try {
    const { name, email, gender } = req.body;
    const updateFields = { dtUp: Date.now() };

    if (!name || !email || !gender) {
      const user = await User.findByIdAndUpdate(
        req.params.id,
        {
          name,
          email,
          gender,
          dtUp: Date.now(),
        },
        { new: true, runValidators: true }
      );

      if (!user) {
        return res.status(404).json({ message: "Users not found" });
      }
      user.passwordHash = undefined;
      return res.json(user);
    }
    return res.status(204).end();
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
