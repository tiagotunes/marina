const express = require("express");
const router = express.Router();

const tasksController = require("../controllers/tasks");

router.get("/:id", tasksController.getTask);

module.exports = router;
