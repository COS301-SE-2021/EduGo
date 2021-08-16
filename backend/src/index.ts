import "reflect-metadata";
import dotenv from "dotenv";
import passport from "passport";
import {
	createConnection,
	ConnectionOptions,
	useContainer as orm_useContainer,
} from "typeorm";
import { Container as orm_Container } from "typeorm-typedi-extensions";
import { Container as di_Container } from "typedi";
import {
	Action,
	createExpressServer,
	useContainer as rc_useContainer,
	useExpressServer,
} from "routing-controllers";

import { LessonController } from "./api/controllers/lessonController";
import { SubjectController } from "./api/controllers/subjectController";
import { AuthController } from "./api/controllers/authController";
import { OrganisationController } from "./api/controllers/OrganisationController";
import { UserController } from "./api/controllers/userController";
import { VirtualEntityController } from "./api/controllers/virtualEntityController";
import express from "express";
import {router as FileRouter} from "./api/controllers/FileController";
import { NodemailerService } from "./api/helper/email/NodemailerService";
import { EducatorService } from "./api/services/EducatorService";
import { AddEducatorsRequest } from "./api/models/user/AddEducatorsRequest";
import { Answer } from "./api/database/Answer";
import { Educator } from "./api/database/Educator";
import { Grade } from "./api/database/Grade";
import { Image } from "./api/database/Image";
import { Lesson } from "./api/database/Lesson";
import { Model } from "./api/database/Model";
import { Organisation } from "./api/database/Organisation";
import { Question } from "./api/database/Question";
import { Quiz } from "./api/database/Quiz";
import { Student } from "./api/database/Student";
import { Subject } from "./api/database/Subject";
import { User } from "./api/database/User";
import { VirtualEntity } from "./api/database/VirtualEntity";
import { UnverifiedUser } from "./api/database/UnverifiedUser";

rc_useContainer(di_Container);
orm_useContainer(orm_Container);

dotenv.config();

if (!("DB_USER" in process.env)) console.log("Database username missing");
if (!("DB_PASSWORD" in process.env)) console.log("Database password missing");
if (!("AWS_ACCESS_KEY" in process.env)) console.log("AWS Access Key missing");
if (!("AWS_SECRET_ACCESS_KEY" in process.env))
	console.log("AWS Secret Access Key missing");
if (!("MAILGUN_API_KEY" in process.env)) console.log("Mailgun API key missing");
if (!("MAILGUN_DOMAIN" in process.env)) console.log("Mailgun domain missing");

// Pass the global passport object into the configuration function
require("./api/middleware/passport")(passport);

const PORT = process.env.PORT || 8080;

let options: ConnectionOptions = {
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
};

createConnection(options)
	.then((conn) => {
		if (conn.isConnected) {
			console.log("Database connection established");
		} else {
			throw new Error("Database connection failed");
		}
	})
	.catch((err) => {
		console.log(err);
	});

export let app = express()
app.use('/virtualEntity', FileRouter);

useExpressServer(app, {
//const app = createExpressServer({
	cors: true,
	controllers: [
		LessonController,
		SubjectController,
		AuthController,
		OrganisationController,
		UserController,
		VirtualEntityController
	],
	currentUserChecker: (action: Action) => action.request.user_id,
});

// let educatorSer = new EducatorService(); 
// let req : AddEducatorsRequest = {educators: ["u19134101@tuks.co.za"]}; 
// educatorSer.AddEducators(req, 1)


app.listen(PORT, () => console.log(`Server listening on port: ${PORT}`));

// import { router as LessonController } from "./api/controllers/LessonController";
// import { router as SubjectController } from "./api/controllers/SubjectController";
// import { router as VirtualEntityController } from "./api/controllers/VirtualEntityController";
// import { router as OrganisationController } from "./api/controllers/OrganisationController";
// import { EmailService } from "./api/helper/email/EmailService";
// import { MailgunEmailService } from "./api/helper/email/MailgunEmailService";
// import { router as AuthController } from "./api/controllers/AuthController";
// import { router as UserController } from "./api/controllers/UserController";
// import { router as SeedController } from "./api/controllers/SeedController";
// import { router as RecommenderController } from './api/controllers/RecommendationController';

// export const app = express();
// app.use(express.urlencoded({ extended: true }));
// app.use(express.json());
// app.use(cors());
// app.use("/lesson", LessonController);
// app.use("/subject", SubjectController);
// app.use("/virtualEntity", VirtualEntityController);
// app.use("/organisation", OrganisationController);
// app.use("/auth", AuthController);
// app.use("/user", UserController);
// app.use("/", SeedController);
// app.use("/recommender", RecommenderController);

// if (process.env.NODE_ENV !== "test")
// 	app.listen(PORT, () => console.log(`Server listening on port: ${PORT}`));
