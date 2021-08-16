import {
	Column,
	Entity,
	ManyToOne,
	OneToMany,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Answer } from "./Answer";
import { Quiz } from "./Quiz";

export enum QuestionType {
	TrueFalse = "TrueFalse",
	MultipleChoice = "MultipleChoice",
	FreeText = "FreeText",
}

@Entity()
export class Question {
	@PrimaryGeneratedColumn()
	id: number;

	@Column({
		type: "enum",
		enum: QuestionType,
		default: QuestionType.TrueFalse,
	})
	type: QuestionType;

	@Column()
	question: string;

	@OneToMany((type) => Answer, (answer) => answer.question)
	answers: Answer[];

	@Column()
	correctAnswer: string;

	@Column("character varying", {
		array: true,
	})
	options: string[];

	@ManyToOne((type) => Quiz, (quiz) => quiz.questions)
	quiz: Quiz;
}
