const express = require("express");
const router = express.Router();

const usersController = require("../controllers/admin/users");
const domainsController = require("../controllers/admin/domains");
const docsController = require("../controllers/admin/documents");
const tasksController = require("../controllers/admin/tasks");

// USERS
router.get("/users/count", usersController.getUserCount);
router.delete("/users/:id", usersController.deleteUser);

// DOMAINS
router.post("/domains", domainsController.addDomain);

// DOCUMENTS
router.post("/docs", docsController.addDoc);
router.put("/docs/:id", docsController.editDoc);
router.delete("/docs/:id", docsController.deleteDoc);

// TASKS
router.get("/tasks", tasksController.getTasks);
router.get("/tasks/count", tasksController.getTasksCount);

module.exports = router;
