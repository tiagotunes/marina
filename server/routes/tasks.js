const express = require("express");
const router = express.Router();

const tasksController = require("../controllers/tasks");
const measureController = require("../controllers/measures");

router.get("/:id", tasksController.getTask);

router.get("/:id/measures", measureController.getMeasures);
router.post("/:id/measures", measureController.addMeasure);

module.exports = router;
