import {
	Column,
	Entity,
	JoinColumn,
	ManyToMany,
	ManyToOne,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { User } from "./User";

@Entity()
export class Educator extends User {
	@Column()
	admin: boolean;
}