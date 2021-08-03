import { Column, Entity, JoinTable, ManyToMany, ManyToOne, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Quiz } from "./Quiz";
import { Student } from "./Student";

@Entity()
export class Grade {
	@PrimaryGeneratedColumn()
	id: number;

	@Column()
	total: number;

	@Column()
	score: number;

    @ManyToOne((type) => Student, (student) => student.grades)
	@JoinTable()
	student: Student;

    @ManyToOne((type)=> Quiz,(quiz) => quiz.grades)
    @JoinTable()
    quiz: Quiz
}
