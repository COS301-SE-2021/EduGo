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
export class Student extends User {}
