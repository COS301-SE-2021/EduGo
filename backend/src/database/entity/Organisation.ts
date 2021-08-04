import { Column, Entity, JoinColumn, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Subject } from "./Subject";
import { UnverifiedUser } from "./UnverifiedUser";
import { User } from "./User";

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

    @OneToMany(type => Subject, subject => subject.organisation, {cascade: true})
    subjects: Subject[];

    @OneToMany(type => User, user => user.organisation)
    users: User[];

    @OneToMany(type => UnverifiedUser, unverifiedUser => unverifiedUser.organisation)
    unverifiedUsers: UnverifiedUser[];

    //Emblem
    //Banner
}