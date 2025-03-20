const express = require("express");
const router = express.Router();

const usersController = require("../controllers/admin/users");
const domainsController = require("../controllers/admin/domains");
const docsController = require("../controllers/admin/documents");
const tasksController = require("../controllers/admin/tasks");
const measureController = require("../controllers/admin/measures");
const mtController = require("../controllers/admin/measureTypes");

// USERS
router.get("/users", usersController.getAllUsers);
router.get("/users/count", usersController.getUsersCount);
router.put("/users/:id", usersController.editUser);
router.delete("/users/:id", usersController.deleteUser);

// DOMAINS
router.get("/domains", domainsController.getAllDomains);
router.post("/domains", domainsController.addDomain);
router.put("/domains/:id", domainsController.editDomain);
router.delete("/domains/:id", domainsController.deleteDomain);

// DOCUMENTS
router.get("/documents", docsController.getDocuments);
router.get("/documents/:id", docsController.getDocumentById);
router.get("/documents/count", docsController.getDocumentsCount);
router.get("/documents/search", docsController.searchDocuments);
router.post("/documents", docsController.addDocument);
router.put("/documents/:id", docsController.editDocument);
router.delete("/documents/:id", docsController.deleteDocument);

// TASKS
router.get("/tasks", tasksController.getTasks);
router.get("/tasks/count", tasksController.getTasksCount);
router.delete("/tasks/:id", tasksController.deleteTask);

// MEASURES
router.post("/tasks/:id/measures", measureController.addMeasure);
router.delete("/tasks/:id/measures", measureController.deleteMeasure);

// MEASURE TYPES
router.get("/measureTypes", mtController.getMeasureTypes);
router.get("/measureTypes/count", mtController.getMeasureTypesCounts);
router.post("/measureTypes", mtController.addMeasureType);
router.put("/measureTypes/:id", mtController.editMeasureType);

module.exports = router;
