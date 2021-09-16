import {
	Entity,
	JoinTable,
	ManyToMany,
	OneToMany,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Grade } from "./Grade";
import { Subject } from "./Subject";
import { User } from "./User";

@Entity()
export class Student {
	@PrimaryGeneratedColumn()
	id: number;

	@ManyToMany((type) => Subject, (subject) => subject.students)
	@JoinTable()
	subjects: Subject[];

	@OneToMany((type) => Grade, (grade) => grade.student, { cascade: true })
	grades: Grade[];

	@OneToOne((type) => User, (user) => user.student)
	user: User;
}
