import { getRepository } from "typeorm";
import { Lesson } from "../database/Lesson";
import { UpcomingLessonsRequest } from "../models/recommendation/UpcomingLessonsRequest";
import { UpcomingLessonsResponse } from "../models/recommendation/UpcomingLessonsResponse";

/**
 * A class consisting of the function that make up the educator service
 * @class RecommendationService
 */
export class RecommendationService {
    /**
     * @param {UpcomingLessonsRequest} body - The body of the request
     * @function getUpcomingLessons 
     * @returns Promise<UpcomingLessonsResponse>
     * @description This function will receive the user id of a user and get a list of the 10 next upcoming lessons for the user from the Lesson Repository
     */
    async getUpcomingLessons(body: UpcomingLessonsRequest): Promise<UpcomingLessonsResponse> {
        let id = body.user_id;
        let LessonRepository = getRepository(Lesson);
        LessonRepository
            .createQueryBuilder()
            .select("lesson")
            

        throw new Error();
    }
}