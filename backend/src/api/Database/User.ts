import {
	Column,
	Entity,
	JoinColumn,
	JoinTable,
	ManyToMany,
	ManyToOne,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Educator } from "./Educator";
import { Organisation } from "./Organisation";
import { Student } from "./Student";
import { Subject } from "./Subject";

@Entity()
export class User {
	@PrimaryGeneratedColumn()
	id: number;

	@Column({ unique: true })
	username: string;

	@Column()
	firstName: string;

	@Column()
	lastName: string;

	@Column({ unique: true })
	email: string;

	@Column()
	hash: string;

	@Column()
	salt: string;

	@ManyToOne((type) => Organisation, (organisation) => organisation.users)
	organisation: Organisation;

	@OneToOne((type) => Student,{
		nullable: true,
		cascade: true,
		onDelete: "CASCADE",
	})
	@JoinColumn()
	student: Student;

	@OneToOne((type) => Educator, {
		nullable: true,
		cascade: true,
		onDelete: "CASCADE",
	})
	@JoinColumn()
	educator: Educator;
}
