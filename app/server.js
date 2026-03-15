const dns = require("dns");
dns.setDefaultResultOrder("ipv4first");

const express = require("express");
const { MongoClient, ObjectId } = require("mongodb");
require("dotenv").config();

const app = express();
app.use(express.json());

// ALB health check
app.get("/", (req, res) => res.status(200).json({ status: "ok" }));

const uri = process.env.MONGODB_URI;
console.log("Mongo URI loaded");

const client = new MongoClient(uri);

let db;

/* ---------------- USERS ROUTES ---------------- */

// Get all users
app.get("/users", async (req, res) => {
  try {
    const users = await db.collection("users").find().toArray();
    res.json(users);
  } catch (err) {
    res.status(500).json({ error: "Failed to fetch users" });
  }
});

// Get single user
app.get("/users/:id", async (req, res) => {
  try {
    const user = await db
      .collection("users")
      .findOne({ _id: new ObjectId(req.params.id) });

    if (!user) return res.status(404).json({ message: "User not found" });

    res.json(user);
  } catch (err) {
    res.status(500).json({ error: "Failed to fetch user" });
  }
});

// Create user
app.post("/users", async (req, res) => {
  try {
    const result = await db.collection("users").insertOne(req.body);
    res.status(201).json(result);
  } catch (err) {
    res.status(500).json({ error: "Failed to create user" });
  }
});

// Update user
app.put("/users/:id", async (req, res) => {
  try {
    const result = await db.collection("users").updateOne(
      { _id: new ObjectId(req.params.id) },
      { $set: req.body }
    );

    res.json(result);
  } catch (err) {
    res.status(500).json({ error: "Failed to update user" });
  }
});

// Delete user
app.delete("/users/:id", async (req, res) => {
  try {
    const result = await db
      .collection("users")
      .deleteOne({ _id: new ObjectId(req.params.id) });

    res.json(result);
  } catch (err) {
    res.status(500).json({ error: "Failed to delete user" });
  }
});

/* ---------------- SERVER START ---------------- */

async function startServer() {
  try {
    console.log("Connecting to MongoDB...");

    await client.connect();

    console.log("MongoDB connected");

    db = client.db("test");

    const PORT = process.env.PORT || 3000;

    app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });

  } catch (err) {
    console.error("MongoDB connection error:", err);
  }
}

startServer();