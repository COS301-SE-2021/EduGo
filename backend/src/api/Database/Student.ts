import {
	Entity,
	JoinTable,
	ManyToMany,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
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
}
