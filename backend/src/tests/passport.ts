import fs from "fs";
import path from "path";
import passport from "passport-jwt";

import { User } from "../api/database/User";
import { getConnection, Repository } from "typeorm";
import { PassportStatic } from "passport";

const JwtStrategy = passport.Strategy;
const ExtractJwt = passport.ExtractJwt;

const pathToKey = path.join(__dirname, "../api/helper/auth/id_rsa_pub.pem");
const PUB_KEY = fs.readFileSync(pathToKey, "utf8");

// At a minimum, you must pass the `jwtFromRequest` and `secretOrKey` properties
const options = {
	jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
	secretOrKey: PUB_KEY,
	algorithms: ["RS256"],
};

export class PassportMiddleware {
	constructor(
		private userRepository: Repository<User>,
		passport: PassportStatic
	) {
		passport.use(
			new JwtStrategy(options, async (payload: any, done: any) => {
				// We will assign the `sub` property on the JWT to the database ID of user
				try {
					const user = await this.userRepository.findOne(payload.sub);
					if (user) return done(null, user);
					else done(null, false);
				} catch (err) {
					return done(err, false);
				}
			})
		);
	}
}
