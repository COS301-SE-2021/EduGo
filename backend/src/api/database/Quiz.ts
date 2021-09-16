import {
	Column,
	Entity,
	JoinTable,
	ManyToMany,
	OneToMany,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Grade } from "./Grade";
import { Question } from "./Question";
import { VirtualEntity } from "./VirtualEntity";

@Entity()
export class Quiz {
	@PrimaryGeneratedColumn()
	id: number;

	@OneToOne((type) => VirtualEntity, (ve) => ve.quiz)
	virtualEntity: VirtualEntity;

	@OneToMany((type) => Question, (question) => question.quiz, {
		cascade: true,
	})
	questions: Question[];

	@OneToMany((type) => Grade, (grade) => grade.quiz, { cascade: true })
	@JoinTable()
	grades: Grade[];
}
