const express = require("express");
const router = express.Router();

const domainsController = require("../controllers/domains");

router.get("/", domainsController.getDomains);
router.get("/:id", domainsController.getDomainById);

module.exports = router;
