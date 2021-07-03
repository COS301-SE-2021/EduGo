import {
	Column,
	Entity,
	JoinTable,
	ManyToMany,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Subject } from "./Subject";

@Entity()
export class User {
	@PrimaryGeneratedColumn()
	id: number;
	
	@Column({unique: true})
	username: string;

	@Column()
	firstName: string;

	@Column()
	lastName: string;

	@Column({unique: true})
	email: string;

	@Column()
	hash: string;

	@Column()
	salt: string;

	@Column()
	organizationId: number;

	@Column()
	verified: boolean;

	@ManyToMany(type => Subject, subjectEnrolled => subjectEnrolled.students)
	@JoinTable()
	subjectsEnrolled: Subject[];

	@ManyToMany(type => Subject, subjectManaging => subjectManaging.educators)
	@JoinTable()
	subjectsManaging: Subject[];
}
