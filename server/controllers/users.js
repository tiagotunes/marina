const { User } = require("../models/user");

/*------------------------------------------------------------------------
  GET 
  /users
------------------------------------------------------------------------*/
exports.getUsers = async (_, res) => {
  try {
    const users = await User.find({ status: "active", admin: false })
      .select("name gender domains")
      .populate({ path: "domains", select: "name" });
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
    const user = await User.findById(req.params.id)
      .select("-passwordHash -resetPasswordOtp -dtResetPasswordOtp -dtCr -dtUp")
      .populate({ path: "domains", select: "name" });

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
        return res.status(404).json({ message: "User not found" });
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
