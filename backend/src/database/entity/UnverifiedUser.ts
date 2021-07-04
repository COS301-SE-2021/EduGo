import { Column, CreateDateColumn, Entity, JoinTable, ManyToMany, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Organisation } from "./Organisation";
import { Subject } from "./Subject";

@Entity()
export class UnverifiedUser {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({unique: true})
    email: string;

    @Column()
    verificationCode: string;

    @CreateDateColumn()
    createdDate: Date;

    @ManyToOne(type => Organisation, organisation => organisation.unverifiedUsers, {cascade: true})
    organisation: Organisation;

    @ManyToMany(type => Subject, subject => subject.unverifiedUsers)
    @JoinTable()
    subjects: Subject[];
}