const express = require("express");

const app = express();

app.get("/health", (req, res) => res.json({ status: "ok" }));
app.get("/", (req, res) => res.json({ service: "eval-express-min" }));

app.listen(8000, "0.0.0.0", () => console.log("listening on 8000"));
