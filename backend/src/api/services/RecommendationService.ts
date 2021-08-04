import { getConnection } from "typeorm";
import { Lesson } from "../database/Lesson";
import { User } from "../database/User";
import { UpcomingLesson, UpcomingLessonsResponse } from "../models/recommendation/UpcomingLessonsResponse";

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
    async getUpcomingLessons(id: number): Promise<UpcomingLessonsResponse> {
        console.log(id);
        let lessons: UpcomingLesson[] = (await getConnection()
            .createQueryBuilder()
            .select("user")
            .from(User, "user")
            .leftJoinAndSelect("user.educator", "educator")
            .leftJoinAndSelect("educator.subjects", "subjects")
            .leftJoinAndSelect("subjects.lessons", "lessons")
            .where("user.id = :id", { id: id })
            .andWhere("lessons.startTime > :start", { start: new Date() })
            //.andWhere("lessons.startTime > :start", { start: new Date("2021-08-31T11:45:00+00:00") })
            //.orderBy("lessons.startTime")
            .getOne()
            .then(user => user ? user.educator.subjects.map(subject => subject.lessons) : []))
            .reduce((acc, next) => acc.concat(next), [])
            .map(lesson => {
                return <UpcomingLesson>{
                    id: lesson.id,
                    title: lesson.title,
                    startTime: lesson.startTime.toISOString(),
                    endTime: lesson.endTime.toISOString(),
                    description: lesson.description
                }
            })
            .sort((a, b) => (a.startTime > b.startTime ? 1 : -1));
        return {lessons: lessons}
    }
}