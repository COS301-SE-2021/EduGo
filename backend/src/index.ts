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
	useContainer as rc_useContainer,
	useExpressServer,
} from "routing-controllers";
import cors from "cors";
import { LessonController } from "./api/controllers/lessonController";
import { SubjectController } from "./api/controllers/subjectController";
import { AuthController } from "./api/controllers/authController";
import { OrganisationController } from "./api/controllers/OrganisationController";
import { UserController } from "./api/controllers/userController";
import { VirtualEntityController } from "./api/controllers/virtualEntityController";
import express from "express";
import {router as FileRouter} from "./api/controllers/FileController";
import ormDevelopment from "./config/typeorm.development";
import ormProduction from "./config/typeorm.production";

rc_useContainer(di_Container);
orm_useContainer(orm_Container);
dotenv.config();
let options: ConnectionOptions = ormDevelopment;

if (!("DB_USER" in process.env)) throw new Error("Database username missing");
if (!("DB_PASSWORD" in process.env)) throw new Error("Database password missing");
if (!("AWS_ACCESS_KEY" in process.env)) throw new Error("AWS Access Key missing");
if (!("AWS_SECRET_ACCESS_KEY" in process.env)) throw new Error("AWS Secret Access Key missing");
if (!("GMAIL_EMAIL" in process.env)) throw new Error("Gmail email missing");
if (!("GMAIL_PASSWORD" in process.env)) throw new Error("Gmail password missing");

if (process.env.NODE_ENV === "production") { 
	if (!("AZURE_DB_SSL_CERT" in process.env)) throw new Error("Azure DB SSL Cert missing");
	options = ormProduction;
}

// Pass the global passport object into the configuration function
require("./api/middleware/passport")(passport);

createConnection(options)
	.then((conn) => {
		if (conn.isConnected) {
			console.log("Database connection established");
		} else {
			throw new Error("Database connection failed");
		}
	})
	.catch((err) => {
		throw new Error(err)
	});

const PORT = process.env.PORT || 8080;
const app = express()
app.use(cors(
	{
		origin: "*",
		methods: "GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS",
	}
))
app.use('/virtualEntity', FileRouter);

useExpressServer(app, {
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

app.listen(PORT, () => console.log(`Server listening on port: ${PORT}`));