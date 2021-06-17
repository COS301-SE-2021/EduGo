  
import { Column, Entity, JoinColumn, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Lesson } from "./Lesson";
@Entity()
export class Subject {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;

    @Column()
    description: string;

    @Column()
    educatorId: string;
    
    @OneToMany(type=> Lesson, lesson => lesson.lessonId )
    @JoinColumn()
    lessons:Lesson[]
}