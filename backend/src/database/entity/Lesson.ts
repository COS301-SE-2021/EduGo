import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
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

    @ManyToOne(() => Subject, subject=> subject.id)
    subject:Subject

    @Column( {nullable: true} )
    virtualEntityID: string
}