import {
	Column,
	Entity,
	ManyToOne,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Grade } from "./Grade";
import { Question } from "./Question";

@Entity()
export class Answer {
	@PrimaryGeneratedColumn()
	id: number;

	@OneToOne((type) => Question, (question) => question.id)
	question: Question;

	@Column()
	givenAnswer: String;

	@ManyToOne((type) => Grade, (grade) => grade.answers)
	grade: Grade;
}
