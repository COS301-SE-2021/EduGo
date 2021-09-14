import { Request } from "express";
import jwtDecode from "jwt-decode";
import passport from "passport";
import {
	BadRequestError,
	UnauthorizedError,
	ExpressMiddlewareInterface,
} from "routing-controllers";
import { Inject, Service } from "typedi";
import { Repository } from "typeorm";
import { InjectRepository } from "typeorm-typedi-extensions";
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

@Service()
export class ValidationMiddleware {
	constructor(
		@InjectRepository(User)
		private readonly userRepository: Repository<User>
	) {}

	public async getUserDetails(id: number): Promise<AuthenticateObject> {
		return this.userRepository
			.findOne(id, { relations: ["educator"] })
			.then((user) => {
				if (user) {
					console.log(user);
					return {
						id: user.id,
						isAdmin:
							user.educator != undefined
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

	public async passportJWT(req: any, res: any, next: any) {
		passport.authenticate("jwt", { session: false });
	}
}

@Service()
export class IsUserMiddleware implements ExpressMiddlewareInterface {
	@Inject() validationMiddleware: ValidationMiddleware;

	async use(
		req: RequestObjectWithUserId,
		res: any,
		next: (err?: any) => any
	) {
		if (req.headers.authorization) {
			const token = req.headers.authorization.slice(7);
			const payload = jwtDecode<MyPayload>(token);
			try {
				const user: AuthenticateObject =
					await this.validationMiddleware.getUserDetails(
						payload.user_id
					);
				if (user) {
					req.user_id = user.id;
					next();
				} else throw new UnauthorizedError("User is not authorized");
			} catch (err) {
				throw err;
			}
		}
	}
}

@Service()
export class IsAdminMiddleware implements ExpressMiddlewareInterface {
	@Inject() validationMiddleware: ValidationMiddleware;

	async use(req: any, res: any, next: (err?: any) => any) {
		try {
			if (req.headers.authorization) {
				const token = req.headers.authorization.slice(7);
				const payload = jwtDecode<MyPayload>(token);

				const user: AuthenticateObject =
					await this.validationMiddleware.getUserDetails(
						payload.user_id
					);
				if (user.isAdmin) {
					req.user_id = user.id;
					next();
				} else throw new UnauthorizedError("User is not an admin");
			} else {
				return "Authorization header not set";
			}
		} catch (err) {
			throw new BadRequestError("No authorization header given");
		}
	}
}

@Service()
export class IsEducatorMiddleware implements ExpressMiddlewareInterface {
	@Inject() validationMiddleware: ValidationMiddleware;

	async use(
		req: RequestObjectWithUserId,
		res: any,
		next: (err?: any) => any
	) {
		if (req.headers.authorization) {
			const token = req.headers.authorization.slice(7);
			const payload = jwtDecode<MyPayload>(token);
			console.log(payload);
			try {
				const user: AuthenticateObject =
					await this.validationMiddleware.getUserDetails(
						payload.user_id
					);
				if (user.isEducator) {
					req.user_id = user.id;
					next();
				} else throw new UnauthorizedError("User is not an Educator");
			} catch (err) {
				throw err;
			}
		}
	}
}
