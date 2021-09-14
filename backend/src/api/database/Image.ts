import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class Image {
	@PrimaryGeneratedColumn()
	id: number;

	@Column()
	name: string;

	@Column()
	link: string;
}
