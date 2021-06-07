import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class VirtualEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    title: string;

    @Column()
    description: string;
}