import fs from "fs";
import path from "path";
const JwtStrategy = require("passport-jwt").Strategy;
const ExtractJwt = require("passport-jwt").ExtractJwt;
import jwtDecode from "jwt-decode";
import passport from "passport";
import { User } from "../../database/entity/User";
import { getConnection } from "typeorm";

const pathToKey = path.join(__dirname, "id_rsa_pub.pem");
const PUB_KEY = fs.readFileSync(pathToKey, "utf8");

// At a minimum, you must pass the `jwtFromRequest` and `secretOrKey` properties
const options = {
	jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
	secretOrKey: PUB_KEY,
	algorithms: ["RS256"],
};

module.exports = (passport: any) => {
	// The JWT payload is passed into the verify callback
	passport.use(
		new JwtStrategy(options, (payload: any, done: any) => {
			console.log(payload);
			let conn = getConnection();
			let UserRepo = conn.getRepository(User);
			// We will assign the `sub` property on the JWT to the database ID of user
			UserRepo.findOne(payload.sub)
				.then((user) => {
					if (user) {
						return done(null, user);
					} else done(null, false);
				})
				.catch((err) => done(err, null));
		})
	);
};

export async function isUser(req: any, res: any, next: any) {
	const token = req.headers.authorization.slice(7);
	const payload = jwtDecode(token);
	console.log(payload);
	next();
}

export async function isAdmin(req: any, res: any, next: any) {
	const token = req.headers.authorization.slice(7);
	const payload = jwtDecode(token);
	console.log(payload);
	next();
}

export async function passportJWT() {
	passport.authenticate("jwt", { session: false });
}
