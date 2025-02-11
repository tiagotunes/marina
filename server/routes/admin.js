const express = require("express");
const router = express.Router();

const usersController = require("../controllers/admin/users");

// USERS
router.get("users/count", usersController.getUserCount);
router.delete("users/:id", usersController.deleteUser);

module.exports = router;
