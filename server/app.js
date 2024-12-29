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

const app = express();
const env = process.env;
const api = env.API_URL;

// Middlewares
app.use(bodyParser.json());
app.use(morgan("tiny"));
app.use(cors());
app.options("*", cors());

// Routes
const authRouter = require("./routes/auth");
app.use(`${api}/`, authRouter);

// Start the server
const hostname = env.HOST;
const port = env.PORT;

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
