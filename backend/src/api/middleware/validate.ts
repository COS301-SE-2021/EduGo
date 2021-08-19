import { Request } from "express";
import jwtDecode from "jwt-decode";
import passport from "passport";
import { InternalServerError, UnauthorizedError } from "routing-controllers";
import { getRepository } from "typeorm";
import { User } from "../database/User";

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

export async function isUser(req: RequestObjectWithUserId, res: any, next: any) {
	if (req.headers.authorization) {
		const token = req.headers.authorization.slice(7);
		const payload = jwtDecode<MyPayload>(token);
		try {
			let user: AuthenticateObject = await getUserDetails(
				payload.user_id
			);
			if (user) {
				next();
			} else throw new UnauthorizedError("User is not authorized");
		} catch (err) {
			throw err;
		}
	}
}

export async function isAdmin(req: any, res: any, next: any) {
	try {
		if (req.headers.authorization) {
			const token = req.headers.authorization.slice(7);
			const payload = jwtDecode<MyPayload>(token);

			let user: AuthenticateObject = await getUserDetails(
				payload.user_id
			);
			if (user.isAdmin) {
				next();
			} else throw new UnauthorizedError("User is not an admin");
		} else {
			 return "Authorization header not set";
		}
	} catch (err) {
		throw console.log(err.message);
	}
}

export async function isEducator(
	req: RequestObjectWithUserId,
	res: any,
	next: any
) {
	if (req.headers.authorization) {
		const token = req.headers.authorization.slice(7);
		const payload = jwtDecode<MyPayload>(token);

		try {
			let user: AuthenticateObject = await getUserDetails(
				payload.user_id
			);
			if (user.isEducator) {
				next();
			} else throw new UnauthorizedError("User is not an Educator");
		} catch (err) {
			throw err;
		}
	}
}

async function getUserDetails(id: number): Promise<AuthenticateObject> {
	return getRepository(User)
		.findOne(id, { relations: ["educator"] })
		.then((user) => {
			if (user) {
				console.log(user.educator);
				return {
					id: user.id,
					isAdmin:
						user.educator !== undefined
							? user.educator.admin
							: false,
					isEducator: user.educator != undefined ? true : false,
				};
			} else
				throw new UnauthorizedError(
					"User not found for get User Details"
				);
		});
}

export function passportJWT(req: any, res: any, next: any) {
	passport.authenticate("jwt", { session: false });
}
