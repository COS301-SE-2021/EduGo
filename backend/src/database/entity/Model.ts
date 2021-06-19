import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class Model {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column()
    description: string;

    @Column()
    file_link: string;

    @Column('float')
    file_size: number;

    @Column()
    file_type: string;

    @Column()
    file_name: string;

    @Column({
        default: ''
    })
    preview_img?: string;
}