import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Quiz } from "./Quiz";

export enum QuestionType {
    TrueFalse = 'TrueFalse',
    MultipleChoice = 'MultipleChoice',
    FreeText = 'FreeText'
}

@Entity()
export class Question {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({
        type: "enum",
        enum: QuestionType,
        default: QuestionType.TrueFalse
    })
    type: QuestionType;

    @Column()
    question: string;

    @Column()
    correctAnswer: string;

    @Column('character varying', {
        array: true
    })
    options: string[];

    @ManyToOne(type => Quiz, quiz => quiz.questions)
    quiz: Quiz;
}