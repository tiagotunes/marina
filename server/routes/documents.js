const express = require("express");
const router = express.Router();

const docsController = require("../controllers/documents");

router.get("/:id", docsController.getDocumentById);

module.exports = router;
