const express = require("express");

const app = express();

app.get("/health", (req, res) => res.json({ status: "ok" }));
app.get("/", (req, res) => res.json({ service: "eval-express-min" }));

app.listen(8000, "0.0.0.0", () => console.log("listening on 8000"));


// DevOps Autopilot: Prometheus instrumentation
try {
  const _dapPromClient = require('prom-client');
  _dapPromClient.collectDefaultMetrics();
  if (typeof app !== 'undefined' && app && typeof app.get === 'function') {
    app.get('/metrics', async (_req, res) => {
      res.set('Content-Type', _dapPromClient.register.contentType);
      res.end(await _dapPromClient.register.metrics());
    });
  }
} catch (e) { /* prom-client not installed yet */ }
