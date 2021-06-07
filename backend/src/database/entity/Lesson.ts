import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class Lesson {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;
    @Column()
    something: string; 

    @Column()
    description: string;
}