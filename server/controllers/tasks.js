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
