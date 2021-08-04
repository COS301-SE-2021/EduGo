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
@Index(["subject", "title", "startTime"], { unique: true })
@Entity()
export class Lesson {
	@PrimaryGeneratedColumn()
	id: number;

	@Column()
	title: string;

	@Column()
	description: string;

	// @Column()
	// date: string;

	// @Column()
	// startTime: string;

	// @Column()
	// endTime: string;

	//Example: 2021-08-01T14:00:00+00:00
	@Column({type: 'timestamptz', nullable: true})
	startTime: Date;

	@Column({type: 'timestamptz', nullable: true})
	endTime: Date;

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