import {
  Column,
  Entity,
  JoinColumn,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Lesson } from "./Lesson";
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
}
