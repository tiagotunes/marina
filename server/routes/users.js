const express = require("express");
const router = express.Router();

const usersController = require("../controllers/users");
const tasksController = require("../controllers/tasks");

router.get("/", usersController.getUsers);
router.get("/:id", usersController.getUserById);
router.get("/:id/tasks", tasksController.getUserTasks);
router.get("/:id/tasks/count", tasksController.getUserTasksCount);

router.post("/:id/tasks", tasksController.addUserTasks);

router.put("/:id", usersController.editUser);

module.exports = router;
