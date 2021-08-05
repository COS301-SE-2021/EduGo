import { Column, Entity, JoinTable, ManyToMany, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Grade } from "./Grade";
import { Question } from "./Question";

@Entity()
export class Quiz {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;

    @Column()
    description: string;

    @OneToMany(type => Question, question => question.quiz, {
        cascade: true
    })
    questions: Question[];

    @OneToMany((type)=> Grade,(grade) => grade.quiz, {cascade:true})
    @JoinTable()
    grades: Grade[]
}