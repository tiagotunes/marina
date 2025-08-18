const { User } = require("../models/user");
const { Task } = require("../models/task");
const { createTasks } = require("../helpers/cron_job");
const { Measure } = require("../models/measure");

/*------------------------------------------------------------------------
  GET 
  /tasks/:id
------------------------------------------------------------------------*/
exports.getTask = async function (req, res) {
  try {
    const task = await Task.findByIdAndUpdate(
      req.params.id,
      { read: true }, // set read to true
      { new: true } // return the updated task
    ).populate([
      {
        path: "docId",
        select: "domainId title text",
        populate: { path: "domainId", select: "name" },
      },
      {
        path: "measures",
        select: "measureTypeId value",
        populate: { path: "measureTypeId", select: "name text" },
      },
    ]);

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
exports.getUserTasks = async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const tasks = await Task.find({ userId: user._id })
      .select("docId read dtDeadline status")
      .populate({ path: "docId", select: "title" })
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
  /users/:id/tasks/count
------------------------------------------------------------------------*/
exports.getUserTasksCount = async function (req, res) {
  try {
    const taskCount = await Task.countDocuments({ userId: req.params.id });
    if (!taskCount) {
      return res.status(500).json({ message: "Could not count user tasks" });
    }
    return res.json({ taskCount });
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  POST 
  /users/:id/tasks
------------------------------------------------------------------------*/
exports.addUserTasks = async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    // if (!createTasks(user._id))
    //   return res
    //     .status(500)
    //     .json({ message: "Could not create new tasks for the user" });
    const ok = await createTasks(user._id);
    if (!ok)
      return res
        .status(500)
        .json({ message: "Could not create new tasks for the user" });

    return res.status(204).end();
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  POST 
  /tasks/:id
------------------------------------------------------------------------*/
exports.editUserTask = async (req, res) => {
  try {
    const task = await Task.findByIdAndUpdate(
      req.params.id,
      { ...req.body, dtUp: Date.now() },
      { new: true, runValidators: true }
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
  PUT 
  /task/:taskId/measures/:measureId
------------------------------------------------------------------------*/
exports.editMeasure = async function (req, res) {
  try {
    let task = await Task.findById(req.params.taskId);
    if (!task) return res.status(404).json({ message: "Task not found" });

    let measure = await Measure.findByIdAndUpdate(
      req.params.measureId,
      { value: req.body.value, dtU: Date.now() },
      { new: true, runValidators: true }
    );
    if (!measure) return res.status(404).json({ message: "Measure not found" });

    task.status = "submit";
    task.dtU = Date.now();
    task = await task.save();

    return res.status(201).json({ task, measure });
  } catch (error) {
    // console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
