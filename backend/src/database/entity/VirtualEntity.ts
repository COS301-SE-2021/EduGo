import { Column, Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Model } from "./Model";
import { Quiz } from "./quiz/Quiz";

@Entity()
export class VirtualEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;

    @Column()
    description: string;

    @OneToOne(type => Quiz, {
        cascade: true
    })
    @JoinColumn()
    quiz?: Quiz;

    @OneToOne(type => Model, {
        cascade: true
    })
    @JoinColumn()
    model?: Model;
}