const { Task } = require("../models/task");

/*------------------------------------------------------------------------
  GET 
  /tasks/:id
------------------------------------------------------------------------*/
exports.getTask = async function (req, res) {
  try {
    const task = await Task.findById(req.params.id).populate(
      {
        path: "docId",
        select: "domainId title text",
        populate: { path: "domainId", select: "name" },
      },
      {
        path: "measures",
        select: "measureTypeId value",
        populate: { path: "measureTypeId", select: "name text" },
      }
    );
    if (!task) {
      return res.status(404).json({ message: "Task not found" });
    }
    return res.json(task);
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
