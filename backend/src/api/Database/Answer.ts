import { Column, Entity, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Question } from "./Question";

@Entity()
export class Answer {
	@PrimaryGeneratedColumn()
	id: number;

	@OneToOne((type) => Question, (question) => question.id)
	question: Question;

	@Column()
	givenAnswer: String;
}
