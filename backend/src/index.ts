import express from "express";
import cors from "cors";
import { createConnection, ConnectionOptions } from "typeorm";
import dotenv from "dotenv";
import passport from "passport";

// Pass the global passport object into the configuration function
require("./auth/lib/passport")(passport);

const PORT = process.env.PORT || 8080;

dotenv.config();

if (!("DB_USER" in process.env)) console.log("Database username missing");
if (!("DB_PASSWORD" in process.env)) console.log("Database password missing");
if (!("AWS_ACCESS_KEY" in process.env)) console.log("AWS Access Key missing");
if (!("AWS_SECRET_ACCESS_KEY" in process.env))
	console.log("AWS Secret Access Key missing");

let options: ConnectionOptions = {
	type: "postgres",
	host: process.env.DB_HOST || "localhost",
	port: 5432,
	username: process.env.DB_USER,
	password: process.env.DB_PASSWORD,
	database: "edugo",
	synchronize: true,
	logging: false,
	entities: ["src/database/entity/**/*.ts"],
	migrations: ["src/database/migration/**/*.ts"],
	subscribers: ["src/database/subscriber/**/*.ts"],
	cli: {
		entitiesDir: "src/database/entity",
		migrationsDir: "src/database/migration",
		subscribersDir: "src/database/subscriber",
	},
};

if (process.env.NODE_ENV !== "test") {
	createConnection(options).then((conn) => {
		if (conn.isConnected) {
			console.log("Database connection established");
		} else {
			throw new Error("Database connection failed");
		}
	});
}

import { router as LessonController } from "./lesson/api/lessonController";
import { router as SubjectController } from "./subject/api/subjectController";
import { router as VirtualEntityController } from "./virtualEntity/api/virtualEntityController";
import { router as AuthController } from "./auth/api/authController";

export const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cors());
app.use("/lesson", LessonController);
app.use("/subject", SubjectController);
app.use("/virtualEntity", VirtualEntityController);
app.use("/auth", AuthController);

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

if (process.env.NODE_ENV !== "test")
	app.listen(PORT, () => console.log(`Server listening on port: ${PORT}`));
