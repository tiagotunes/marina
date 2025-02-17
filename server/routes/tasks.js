const express = require("express");
const router = express.Router();

const tasksController = require("../controllers/tasks");

router.get("/", tasksController.getUserTasks);
router.get("/", tasksController.getTask);

module.exports = router;
