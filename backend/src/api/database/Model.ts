import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class Model {
	@PrimaryGeneratedColumn()
	id: number;

	@Column()
	fileLink: string;

	@Column({ nullable: true })
	thumbnail?: string;
}
