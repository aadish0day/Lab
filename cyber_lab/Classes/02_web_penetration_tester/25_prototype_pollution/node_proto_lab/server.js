const express = require("express");
const _ = require("lodash");

const app = express();
app.use(express.json());

// Target configuration object without an own admin property
let config = {
  debug: false,
};

app.get("/", (req, res) => {
  const isAdmin = Boolean(config.admin || Object.prototype.admin);
  res.send(`<h1>Prototype Pollution Target</h1>
<p>Status: Running</p>
<p>Admin Flag: ${isAdmin ? "FLAG{PROTO_POLLUTED_ROOT}" : "ACCESS_DENIED"}</p>`);
});

// Deep merge endpoint vulnerable to Prototype Pollution (Lodash CVE-2018-3721 / CVE-2019-10744)
const handleMerge = (req, res) => {
  const payload = req.body;
  _.merge({}, payload);
  res.json({
    status: "processed",
    admin: Object.prototype.admin || false,
  });
};

app.post("/pollute", handleMerge);
app.post("/api/update", handleMerge);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Proto-Pollution target listening on port ${PORT}`);
});
