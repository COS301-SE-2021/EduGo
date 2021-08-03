import express from "express";
import passport from "passport";
import { isUser, RequestObjectWithUserId } from "../middleware/validate";

const router = express.Router();

router.post(
    '/upcomingLessons', 
    passport.authenticate("jwt", { session: false }),
    isUser,
    (req: RequestObjectWithUserId, res: any) => {
        
    }
);