const jwt = require("jsonwebtoken");
const { default: mongoose } = require("mongoose");

async function authorizePostRequest(req, res, next) {
  const API = process.env.API_URL;
  const message =
    "User conflict. The user making the request doesn't match the user in the request";

  if (req.method !== "POST") return next();
  if (req.originalUrl.startsWith(`${API}/admin`)) {
    return next();
  }

  const endpoints = [
    `${API}/login`,
    `${API}/register`,
    `${API}/forgot-password`,
    `${API}/reset-password`,
    `${API}/verify-otp`,
    `${API}/verify-token`,
  ];
  const isMatchingEndpoint = endpoints.some((ep) =>
    req.originalUrl.includes(ep)
  );
  if (isMatchingEndpoint) return next();

  const authHeader = req.header("Authorization");
  if (!authHeader) return next();

  const accessToken = authHeader.replace("Bearer", "").trim();
  const tokenData = jwt.decode(accessToken);

  if (req.body.userId && tokenData.id !== req.body.userId) {
    return res.staus(401).json({ message });
  } else if (/\/users\/([^/]+)\//.test(req.originalUrl)) {
    const urlParts = req.originalUrl.split("/");
    const usersIndex = urlParts.indexOf("users");
    const id = urlParts[usersIndex + 1];

    if (!mongoose.isValidObjectId(id)) return next();
    if (tokenData.id !== id) return res.status(401).json({ message });
  }
  return next();
}

module.exports = authorizePostRequest;
