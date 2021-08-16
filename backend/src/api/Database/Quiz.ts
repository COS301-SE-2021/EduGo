import { Column, Entity, JoinTable, ManyToMany, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Grade } from "./Grade";
import { Question } from "./Question";
import { VirtualEntity } from "./VirtualEntity";

@Entity()
export class Quiz {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;

    @OneToOne(type => VirtualEntity, ve => ve.quiz)
	virtualEntity: VirtualEntity;

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