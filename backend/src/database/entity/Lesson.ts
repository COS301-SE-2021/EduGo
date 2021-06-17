import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import {Subject} from "./Subject"
@Entity()
export class Lesson {
   
    @PrimaryGeneratedColumn()
    lessonId: number;

    @Column()
    title: string;

    @Column()
    description: string;
    
    @Column()
    date: string; 

    @ManyToOne(type => Subject, subject=> subject.id)
    @Column()
    subject:Subject

    @Column( {nullable: true} )
    virtualEntityID: string
}