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

	@OneToOne(type => User, user => user.student)
	user: User;

	@ManyToMany(type => Subject, subject => subject.students)
	@JoinTable()
	subjects: Subject[];

	@OneToMany((type) => Grade, (grade) => grade.student)
	@JoinTable()
	grades: Grade[];
}
