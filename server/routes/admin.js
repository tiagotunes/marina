const express = require("express");
const router = express.Router();

const usersController = require("../controllers/admin/users");
const docsController = require("../controllers/admin/documents");
const tasksController = require("../controllers/admin/tasks");

// USERS
router.get("users/count", usersController.getUserCount);
router.delete("users/:id", usersController.deleteUser);

// DOCUMENTS
router.get("docs", docsController.addDoc);
router.put("docs/:id", docsController.editDoc);
router.delete("docs/:id", docsController.deleteDoc);

// TASKS
router.get("tasks", tasksController.getTasks);
router.get("tasks/count", tasksController.getTasksCount);

module.exports = router;
