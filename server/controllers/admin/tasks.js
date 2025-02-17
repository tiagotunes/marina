const { Task } = require("../../models/task");

exports.getTasks = async function (req, res) {
  try {
    const tasks = await Task.find()
      // .select("-dtCr -dtUp")
      // .populate("userId", "name role")
      .sort({ dtDeadline: -1 })
      .populate({
        path: "measures",
        populate: {
          path: "measureTypeId",
          select: "name",
        },
      });
    if (!tasks) {
      return res.status(404).json({ message: "Tasks not found" });
    }
    return res.json(tasks);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.getTasksCount = async function (req, res) {};
