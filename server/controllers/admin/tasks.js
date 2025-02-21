const { Task } = require("../../models/task");

/*------------------------------------------------------------------------
  GET 
  /admin/tasks
------------------------------------------------------------------------*/
exports.getTasks = async function (req, res) {
  try {
    const tasks = await Task.find()
      .select("-dtCr -dtUp")
      .populate({
        path: "docId",
        select: "title",
      })
      .populate({
        path: "userId",
        select: "name role",
      })
      .populate({
        path: "measures",
        select: "value",
        populate: {
          path: "measureTypeId",
          select: "name",
        },
      })
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
  GET 
  /admin/tasks/count
------------------------------------------------------------------------*/
exports.getTasksCount = async function (_, res) {
  try {
    const taskCount = await Task.countDocuments();
    if (!taskCount) {
      return res.status(500).json({ message: "Could not count tasks" });
    }
    return res.json({ taskCount });
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
