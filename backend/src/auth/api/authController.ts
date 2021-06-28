import express from "express";

const router = express.Router();

router.use((req, res, next) => {
	next();
});

router.get("/protected", async (req, res, next) => {});

router.post("/login", async (req, res) => {});

router.post("/register", async (req, res) => {});

export { router };
