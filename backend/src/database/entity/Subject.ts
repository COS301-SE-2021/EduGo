import {
  Column,
  Entity,
  JoinColumn,
  ManyToMany,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Lesson } from "./Lesson";
import { Organisation } from "./Organisation";
import { User } from "./User";
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

  @ManyToOne(() => Organisation, organisation => organisation.subjects)
  @JoinColumn()
  organisation: Organisation;

  @ManyToMany(type => User, student => student.subjectsEnrolled, {cascade: true})
  students: User[];

  @ManyToMany(type => User, educator => educator.subjectsManaging, {cascade: true})
  educators: User[];
}
