const express = require("express");
const router = express.Router();

const usersController = require("../controllers/admin/users");
const domainsController = require("../controllers/admin/domains");
const docsController = require("../controllers/admin/documents");
const tasksController = require("../controllers/admin/tasks");
const mtController = require("../controllers/admin/measureTypes");

// USERS
router.get("/users/count", usersController.getUsersCount);
router.post("/users/:id", usersController.updateUser);
router.delete("/users/:id", usersController.deleteUser);

// DOMAINS
router.post("/domains", domainsController.addDomain);

// DOCUMENTS
router.get("/documents", docsController.getDocuments);
router.get("/documents/count", docsController.getDocumentsCount);
router.get("/documents/search", docsController.searchDocuments);
router.post("/documents", docsController.addDocument);
router.put("/documents/:id", docsController.editDocument);

// TASKS
router.get("/tasks", tasksController.getTasks);
router.get("/tasks/count", tasksController.getTasksCount);

// MEASURE TYPES
router.get("/measureTypes", mtController.getMeasureTypes);
router.get("/measureTypes/count", mtController.getMeasureTypesCounts);
router.post("/measureTypes", mtController.addMeasureType);

module.exports = router;
