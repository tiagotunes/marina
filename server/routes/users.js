const express = require("express");
const router = express.Router();

const usersController = require("../controllers/users");
const tasksController = require("../controllers/tasks");

router.get("/", usersController.getUsers);
router.get("/:id", usersController.getUserById);
router.get("/:id/tasks", tasksController.getUserTaks);
router.put("/:id", usersController.editUser);

module.exports = router;
