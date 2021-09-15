import {
	Column,
	Entity,
	Index,
	JoinColumn,
	JoinTable,
	ManyToOne,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Grade } from "./Grade";
import { Question } from "./Question";
@Index(["question", "grade"], { unique: true })
@Entity()
export class Answer {
	@PrimaryGeneratedColumn()
	id: number;

	@ManyToOne((type) => Question, (question) => question.answers)
	question: Question;

	@Column()
	answer: String;

	@ManyToOne((type) => Grade, (grade) => grade.answers, {
		onDelete: "CASCADE",
	})
	grade: Grade;
}
