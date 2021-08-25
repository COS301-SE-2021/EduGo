import { truncate } from "fs/promises";
import {
	Column,
	Entity,
	Index,
	JoinTable,
	ManyToMany,
	ManyToOne,
	OneToMany,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Answer } from "./Answer";
import { Lesson } from "./Lesson";
import { Quiz } from "./Quiz";
import { Student } from "./Student";
import { Subject } from "./Subject";
@Index(["student", "quiz", "lesson"], { unique: true })
@Entity()
export class Grade {
	@PrimaryGeneratedColumn()
	id: number;

	@Column()
	total: number;

	@Column()
	score: number;

	@ManyToOne((type) => Student, (student) => student.grades)
	@JoinTable()
	student: Student;

	@ManyToOne((type) => Quiz, (quiz) => quiz.grades)
	quiz: Quiz;

	@ManyToOne((type) => Lesson, (lesson) => lesson.grades, { cascade: true })
	lesson: Lesson;

	@ManyToOne((type) => Subject, (subject) => subject.grades)
	subject: Subject;

	@OneToMany((type) => Answer, (answer) => answer.grade, { cascade: true })
	answers: Answer[];
}
