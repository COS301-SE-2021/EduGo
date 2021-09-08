import express from "express";
import passport from "passport";
import { isUser, RequestObjectWithUserId } from "../middleware/ValidationMiddleware";
import { RecommendationService } from "../services/RecommendationService";

const router = express.Router();

const service = new RecommendationService();

router.post(
    '/upcomingLessons', 
    passport.authenticate("jwt", { session: false }),
    isUser,
    (req: RequestObjectWithUserId, res: any) => {
        let id = (<any>req.user!).id;
        service.getUpcomingLessons(id).then(lessons => {
            res.json(lessons);
        });
    }
);

export {router};