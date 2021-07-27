import {
	Column,
	Entity,
	Index,
	JoinColumn,
	JoinTable,
	ManyToMany,
	ManyToOne,
	OneToMany,
	PrimaryGeneratedColumn,
} from "typeorm";
import { Subject } from "./Subject";
import { VirtualEntity } from "./VirtualEntity";
@Index(["subject", "title"], { unique: true })
@Entity()
export class Lesson {
	@PrimaryGeneratedColumn()
	id: number;

	@Column()
	title: string;

	@Column()
	description: string;

	@Column()
	date: string;

	@Column()
	startTime: string;

	@Column()
	endTime: string;

	@JoinColumn()
	@ManyToOne(() => Subject, (subject) => subject.lessons)
	subject: Subject;

	@ManyToMany(
		(type) => VirtualEntity,
		(virtualEntities) => virtualEntities.lessons,
		{
			cascade: true,
		}
	)
	@JoinTable()
	virtualEntities: VirtualEntity[];
}
