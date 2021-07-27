import { Request } from "express";
import jwtDecode from "jwt-decode";
import passport from "passport";
import { getRepository } from "typeorm";
import { User } from "../database/User";
import { NonExistantItemError } from "../errors/NonExistantItemError";
import { UnauthorizedUserError } from "../errors/UnauthorizedUserError";
import { handleErrors } from "../helper/ErrorCatch";
// TODO add rules
interface MyPayload {
	user_id: number;
}
interface AuthenticateObject {
	id: number;
	isAdmin: boolean;
	isEducator: boolean;
}

export interface RequestObjectWithUserId extends Request {
	user_id: number;
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
export async function isEducator(
	req: RequestObjectWithUserId,
	res: any,
	next: any
) {
	if (req.headers.authorization) {
		const token = req.headers.authorization.slice(7);
		const payload = jwtDecode<MyPayload>(token);

		console.log(payload);
		try {
			let user: AuthenticateObject = await getUserDetails(
				payload.user_id
			);
			if (user.isEducator) {
				next();
			} else throw new UnauthorizedUserError("User is not an Educator");
		} catch (err) {
			handleErrors(err, res);
		}
	}
	res.status(500);
}

async function getUserDetails(id: number): Promise<AuthenticateObject> {
	return getRepository(User)
		.findOne({ id: id })
		.then((user) => {
			if (user) {
				return {
					id: user.id,
					isAdmin:
						user.educator !== undefined
							? user.educator.admin
							: false,
					isEducator: user.educator !== undefined ? true : false
				};
			} else throw new NonExistantItemError("User not found");
		});
}

export function passportJWT(req: any, res: any, next: any) {
	passport.authenticate("jwt", { session: false });
}
