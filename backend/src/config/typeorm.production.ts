import dotenv from 'dotenv';
import { ConnectionOptions } from 'typeorm';
import { Answer } from "../api/database/Answer";
import { Educator } from "../api/database/Educator";
import { Grade } from "../api/database/Grade";
import { Image } from "../api/database/Image";
import { Lesson } from "../api/database/Lesson";
import { Model } from "../api/database/Model";
import { Organisation } from "../api/database/Organisation";
import { Question } from "../api/database/Question";
import { Quiz } from "../api/database/Quiz";
import { Student } from "../api/database/Student";
import { Subject } from "../api/database/Subject";
import { UnverifiedUser } from "../api/database/UnverifiedUser";
import { User } from "../api/database/User";
import { VirtualEntity } from "../api/database/VirtualEntity";

dotenv.config();

export default {
	type: "postgres",
	host: process.env.DB_HOST || "localhost",
	port: 5432,
	username: process.env.DB_USER,
	password: process.env.DB_PASSWORD,
	database: "edugo",
	synchronize: true,
	logging: true,
	logger: "file",
	entities: [
		Answer, 
		Educator, 
		Grade, 
		Image, 
		Lesson, 
		Model, 
		Organisation, 
		Question, 
		Quiz, 
		Student, 
		Subject, 
		UnverifiedUser,
		User, 
		VirtualEntity
	],
	migrations: ["src/api/database/migration/**/*.ts"],
	subscribers: ["src/api/database/subscriber/**/*.ts"],
	cli: {
		entitiesDir: "src/api/database/entity",
		migrationsDir: "src/api/database/migration",
		subscribersDir: "src/api/database/subscriber",
	},
	extra: {
		ssl: true
	},
	ssl: {
		ca: Buffer.from(process.env.AZURE_DB_SSL_CERT!, 'base64').toString('ascii'),
	}
} as ConnectionOptions