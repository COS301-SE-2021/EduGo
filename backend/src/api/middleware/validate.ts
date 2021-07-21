import jwtDecode from "jwt-decode";
import passport from "passport";
import { getRepository } from "typeorm";
import {User} from "../database/User"
// TODO add rules

interface AuthenticateObject {
	id: number;
	isAdmin: boolean;
	isEducator: boolean; 
	organisation_id : number; 
}

export async function isUser(req: any, res: any, next: any) {
	const token = req.headers.authorization.slice(7);
	const payload = jwtDecode(token);
	console.log(payload);
	next();
}

// TODO add rules
export async function isAdmin(req: any, res: any, next: any) {
	const token = req.headers.authorization.slice(7);
	const payload = jwtDecode(token);
	console.log(payload);
	next();
}
// TODO add rules
export async function isEducator(req: any, res: any, next: any) {
	const token = req.headers.authorization.slice(7);
	const payload = jwtDecode(token);
	console.log(payload);
	next();
}

async function authenticate(id: number): Promise<AuthenticateObject> {
	return getRepository(User).findOne({ id: id }).then(user => {
		if (user) {
			return {
				id: user.id,
				isAdmin: user.educator !== undefined ? user.educator.admin : false,
				isEducator: user.educator !== undefined ? true : false,
				organisation_id: user.organisation.id
			}
		}
		//TODO: Add exception for non-existing user
		throw new Error("User not found");
	});
}

export async function passportJWT() {
	passport.authenticate("jwt", { session: false });
}
