import express from "express";
import passport from "passport";
import { RegisterRequest } from "../models/RegisterRequest";
import {register} from "../service/authService"
const router = express.Router();

router.use((req, res, next) => {
	next();
});

router.get("/protected", passport.authenticate('jwt', { session: false }), (req, res, next) => {
    res.status(200).json({ success: true, msg: "You are successfully authenticated to this route!"});
});
router.post("/login", async (req, res) => {});

router.post("/register", async (req, res) => {

	register(<RegisterRequest> req.body).then(user=> {

		if(user){
			res.status(200); 
			res.json(user); 
		}
	})

	
});

export { router };
