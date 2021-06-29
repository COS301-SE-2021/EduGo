import {
	Column,
	Entity,
	PrimaryGeneratedColumn,
} from "typeorm";

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
}
