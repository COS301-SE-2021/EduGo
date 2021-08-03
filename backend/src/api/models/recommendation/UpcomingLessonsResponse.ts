interface Lesson {
    id: number;
    title: string;
    description: string;
    startTime: string;
    endTime: string;
}

export interface UpcomingLessonsResponse {
    lessons: Lesson[];
}