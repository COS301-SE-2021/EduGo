import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class Lesson {
    @ManyToOne(type => Lesson, lesson=> lesson.id)
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;

    @Column()
    description: string;
    
    @Column()
    date: string; 

    @Column( {nullable: true} )
    virtualEntityID: string
}