import { Column, Entity, JoinColumn, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Subject } from "./Subject";

@Entity()
export class Organisation {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column()
    email: string;

    @Column()
    phone: string;

    @OneToMany((type) => Subject, (subject) => subject.organisation, {cascade: true})
    @JoinColumn()
    subjects: Subject[];

    //Emblem
    //Banner
}