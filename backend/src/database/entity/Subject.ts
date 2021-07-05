import {
  Column,
  Entity,
  JoinColumn,
  ManyToMany,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Educator } from "./Educator";
import { Lesson } from "./Lesson";
import { Organisation } from "./Organisation";
import { Student } from "./Student";
import { UnverifiedUser } from "./UnverifiedUser";

@Entity()
export class Subject {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  @Column()
  grade: number;

  @OneToMany((type) => Lesson, (lesson) => lesson.subject, { cascade: true })
  @JoinColumn()
  lessons: Lesson[];

  @ManyToOne(() => Organisation, organisation => organisation.subjects)
  @JoinColumn()
  organisation: Organisation;

  @ManyToMany(type => Student, student => student.subjects, {cascade: true})
  students: Student[];

  @ManyToMany(type => Educator, educator => educator.subjects, {cascade: true})
  educators: Educator[];

  @ManyToMany(type => UnverifiedUser, unverifiedUser => unverifiedUser.subjects)
  unverifiedUsers: UnverifiedUser[];
}
