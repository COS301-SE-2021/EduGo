import express from "express";

import { RegisterRequest } from "../models/registerRequest";
import { json } from "body-parser";
const router = express.Router();

router.use((req, res, next) => {
	next();
});

export { router };
