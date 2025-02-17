const express = require("express");
const router = express.Router();

const docsController = require("../controllers/documents");

router.get("/", docsController.getDocs);
router.get("/:id", docsController.getDocById);

module.exports = router;
