const express = require("express");
const http = require("http");
const app = express();

const server = http.createServer(app);

app.get("/test", (req, res) => {
  res.send("We are testing the server");
});

server.listen(5000);
