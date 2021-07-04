import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Lesson } from "./Lesson";
import { Organisation } from "./Organisation";
@Entity()
export class Subject {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  @Column()
  description: string;

  @Column({nullable: true})
  grade: number;

  @Column()
  educatorId: number;

  @OneToMany((type) => Lesson, (lesson) => lesson.subject, { cascade: true })
  @JoinColumn()
  lessons: Lesson[];
  @Column()
	image: string;

  @ManyToOne(() => Organisation, organisation => organisation.subjects)
  @JoinColumn()
  organisation: Organisation;
}
