/*
 js -> language
 Node.js runtime -> environment
 Express.js -> framework
*/

// Import libraries
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const morgan = require("morgan");
const bodyParser = require("body-parser");
require("dotenv/config");

// Middlewares
const authJwt = require("./middlewares/jwt");
const authorizePostRequest = require("./middlewares/authorization");
const errorHandler = require("./middlewares/error_handler");

// Cron jobs
require("./helpers/cron_job");

// Destructure env vars
const {
  API_URL,
  HOST = "0.0.0.0",
  PORT = 3000,
  MONGODB_CONNECTION_STRING,
} = process.env;

const app = express();

/* ------------------- Global Middlewares ------------------- */
app.use(bodyParser.json());
app.use(morgan("tiny"));
app.use(cors());
app.options("*", cors());

/* ------------------- Public Routes ------------------- */
app.get("/", (req, res) => {
  res.send("API está ativa");
});

/* ------------------- Protected Middlewares ------------------- */
app.use(authJwt());
app.use(authorizePostRequest);

/* ------------------- API Routes ------------------- */
app.use(`${API_URL}/admin`, require("./routes/admin"));
app.use(`${API_URL}/`, require("./routes/auth"));
app.use(`${API_URL}/domains`, require("./routes/domains"));
app.use(`${API_URL}/tasks`, require("./routes/tasks"));
app.use(`${API_URL}/users`, require("./routes/users"));

// Static files
app.use("/public", express.static(__dirname + "/public"));

/* ------------------- Error Handler ------------------- */
app.use(errorHandler);

/* ------------------- Database Connection ------------------- */
mongoose
  .connect(MONGODB_CONNECTION_STRING)
  .then(() => console.log("Connected to database"))
  .catch((err) => console.error("DB connection error:", err));

/* ------------------- Start Server ------------------- */
app.listen(PORT, HOST, () => {
  console.log(`Server running at http://${HOST}:${PORT}`);
});
