import {
	Column,
	Entity,
	JoinColumn,
	ManyToMany,
	ManyToOne,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
@Entity()
export class User {
	@PrimaryGeneratedColumn()
	id: number;
	@Column()
	username: string;

	@Column()
	firstName: string;

	@Column()
	lastName: string;

	@Column()
	email: string;

	@Column()
	hash: string;

	@Column()
	salt: string;

	@Column()
	organizationId: number;

	@Column()
	verified: boolean;

	@Column()
	isAdmin: boolean;

	@Column()
	type: string;
}
