import {
	Column,
	Entity,
	JoinTable,
	ManyToMany,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Subject } from "./Subject";
import { User } from "./User";

@Entity()
export class Educator {
	@PrimaryGeneratedColumn()
	id: number;

	@OneToOne(type => User, user => user.educator)
	user: User;

	@ManyToMany(type => Subject, subject => subject.educators)
	@JoinTable()
	subjects: Subject[];

	@Column({default:false})
	admin: boolean;
}
