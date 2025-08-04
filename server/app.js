/*
 js -> language
 Node.js runtime -> environment
 Express.js -> framework
*/

// Import libraries
const bodyParser = require("body-parser");
const cors = require("cors");
const express = require("express");
const mongoose = require("mongoose");
const morgan = require("morgan");
require("dotenv/config");
const authJwt = require("./middlewares/jwt");
const authorizePostRequest = require("./middlewares/authorization");
const errorHandler = require("./middlewares/error_handler");

const app = express();
const env = process.env;
const api = env.API_URL;

// Middlewares
app.use(bodyParser.json());
app.use(morgan("tiny"));
app.use(cors());
app.options("*", cors());
app.use(authJwt());
app.use(authorizePostRequest);
app.use(errorHandler);

// Routes
const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");
const domainsRouter = require("./routes/domains");
const tasksRouter = require("./routes/tasks");
const usersRouter = require("./routes/users");

app.use(`${api}/admin`, adminRouter);
app.use(`${api}/`, authRouter);
app.use(`${api}/domains`, domainsRouter);
app.use(`${api}/tasks`, tasksRouter);
app.use(`${api}/users`, usersRouter);
app.use("/public", express.static(__dirname + "/public"));

app.get("/", (req, res) => {
  res.send("API está ativa");
});

// Start the server
const hostname = env.HOST || "0.0.0.0";
const port = env.PORT || 3000;

require("./helpers/cron_job");

mongoose
  .connect(env.MONGODB_CONNECTION_STRING)
  .then(() => {
    console.log("Connected to database");
  })
  .catch((error) => {
    console.error(error);
  });

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}`);
});

/*
[C]reate data -> app.post()
[R]ead data -> app.get()
[U]pdate data -> app.put()
[D]elete data -> app.delete()
*/
