import 'reflect-metadata';
import dotenv from "dotenv";
import passport from "passport";
import { createConnection, ConnectionOptions, useContainer as orm_useContainer } from "typeorm";
import { Container as orm_Container} from "typeorm-typedi-extensions";
import { Container as di_Container} from "typedi";
import { Action, createExpressServer, useContainer as rc_useContainer } from 'routing-controllers';

import { LessonController } from './api/controllers/lessonController';
import { SubjectController } from './api/controllers/subjectController';
import { AuthController } from './api/controllers/authController';

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
	entities: ["src/api/database/**/*.ts"],
	migrations: ["src/api/database/migration/**/*.ts"],
	subscribers: ["src/api/database/subscriber/**/*.ts"],
	cli: {
		entitiesDir: "src/api/database/entity",
		migrationsDir: "src/api/database/migration",
		subscribersDir: "src/api/database/subscriber",
	},
};

createConnection(options).then((conn) => {
	if (conn.isConnected) {
		console.log("Database connection established");
	} else {
		throw new Error("Database connection failed");
	}
}).catch((err) => {
	console.log(err);
});

const app = createExpressServer({
	cors: true,
	controllers: [
		LessonController,
		SubjectController,
		AuthController, 
	],
	currentUserChecker: (action: Action) => action.request.user
});

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