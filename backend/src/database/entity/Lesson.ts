import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import {Subject} from "./Subject"
@Entity()
export class Lesson {
   
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;

    @Column()
    description: string;
    
    @Column()
    date: string; 

    @JoinColumn()
    @ManyToOne(() => Subject, subject=> subject.lessons)
    subject:Subject

    @Column( {nullable: true} )
    virtualEntityID: string
}