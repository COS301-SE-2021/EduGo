import { Column, CreateDateColumn, Entity, JoinTable, ManyToMany, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Organisation } from "./Organisation";
import { Subject } from "./Subject";

export type UserType = 'student' | 'educator'

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

    @ManyToOne(type => Organisation, organisation => organisation.unverifiedUsers, {cascade: true, onDelete: "CASCADE"})
    organisation: Organisation;

    @ManyToMany(type => Subject, subject => subject.unverifiedUsers)
    @JoinTable()
    subjects: Subject[];

    @Column()
    type: UserType
}