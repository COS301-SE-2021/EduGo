import express from "express";
import cors from "cors";
import { createConnection, ConnectionOptions, QueryFailedError } from "typeorm";
import dotenv from "dotenv";
import passport from "passport";

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
	entities: ["src/api/database/**/*.ts"],
	migrations: ["src/api/database/migration/**/*.ts"],
	subscribers: ["src/api/database/subscriber/**/*.ts"],
	cli: {
		entitiesDir: "src/api/database/entity",
		migrationsDir: "src/api/database/migration",
		subscribersDir: "src/api/database/subscriber",
	},
};

if (process.env.NODE_ENV !== "test") {
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
}

import { router as LessonController } from "./api/controllers/LessonController";
import { router as SubjectController } from "./api/controllers/SubjectController";
import { router as VirtualEntityController } from "./api/controllers/VirtualEntityController";
import { router as OrganisationController } from "./api/controllers/OrganisationController";
import { EmailService } from "./api/helper/email/EmailService";
import { MailgunEmailService } from "./api/helper/email/MailgunEmailService";
import { router as AuthController } from "./api/controllers/AuthController";
import { router as UserController } from "./api/controllers/UserController";
import { router as SeedController } from "./api/controllers/SeedController";
import { router as RecommenderController } from './api/controllers/RecommendationController';

export const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cors());
app.use("/lesson", LessonController);
app.use("/subject", SubjectController);
app.use("/virtualEntity", VirtualEntityController);
app.use("/organisation", OrganisationController);
app.use("/auth", AuthController);
app.use("/user", UserController);
app.use("/", SeedController);
app.use("/recommender", RecommenderController);

/*
 * Look, it's a comment
 * TODO Fix this
 */

// app.use((req, res, next) => {
//     express.json()(req, res, err => {
//         if (err) {
//             if (err instanceof SyntaxError) {

//             }
//         }
//     })
// })

app.get("/", (req, res) => {
	res.send("hey there");
});

app.post("/email", (req, res) => {
	let { to, name, code } = req.body;

	let emailService: EmailService = new MailgunEmailService();
	emailService.sendOneEmail(to, name, code);
	res.status(200).send();
});

if (process.env.NODE_ENV !== "test")
	app.listen(PORT, () => console.log(`Server listening on port: ${PORT}`));