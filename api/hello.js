// Vercel serverless function, served at /api/hello
module.exports = function handler(req, res) {
  res.status(200).json({
    message: "Hello from a Vercel serverless function",
    time: new Date().toISOString(),
  });
};
