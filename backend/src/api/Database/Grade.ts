import {
	Column,
	Entity,
	JoinTable,
	ManyToMany,
	ManyToOne,
	OneToMany,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Answer } from "./Answer";
import { Quiz } from "./Quiz";
import { Student } from "./Student";

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
	@JoinTable()
	quiz: Quiz;

	@OneToMany(type=>Answer , answer=>answer.grade)
	answers: Answer[];
}
