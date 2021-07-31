import {
	Column,
	Entity,
	JoinColumn,
	OneToMany,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Subject } from "./Subject";
import { UnverifiedUser } from "./UnverifiedUser";
import { User } from "./User";

@Entity()
export class Organisation {
	@PrimaryGeneratedColumn()
	id: number;

	@Column({unique:true})
	name: string;

	@Column({unique:true})
	email: string;

	@Column({unique:true})
	phone: string;

	@OneToMany((type) => Subject, (subject) => subject.organisation, {
		cascade: true,
		onDelete: "CASCADE",
	})
	subjects: Subject[];

	@OneToMany((type) => User, (user) => user.organisation, {
		onDelete: "CASCADE",
	})
	users: User[];

	@OneToMany(
		(type) => UnverifiedUser,
		(unverifiedUser) => unverifiedUser.organisation,
		{ onDelete: "CASCADE" }
	)
	unverifiedUsers: UnverifiedUser[];

	//Emblem
	//Banner
}
