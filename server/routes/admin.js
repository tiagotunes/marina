const express = require("express");
const router = express.Router();

const adminController = require("../controllers/admin");

// USERS
router.get("users/count", adminController.getUserCount);
router.delete("users/:id", adminController.deleteUser);

module.exports = router;
