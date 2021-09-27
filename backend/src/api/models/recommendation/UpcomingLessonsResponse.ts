export interface UpcomingLesson {
	id: number;
	title: string;
	description: string;
	startTime: string;
	endTime: string;
	subject: string;
}

export interface UpcomingLessonsResponse {
	lessons: UpcomingLesson[];
}
