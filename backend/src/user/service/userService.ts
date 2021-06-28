import { ApiResponse } from "../../models/apiResponse";
import { Any, createConnection, getConnection } from "typeorm";
import { Educator } from "../../database/entity/Educator";
import { Student } from "../../database/entity/Student";
import { RegisterRequest } from "../models/registerRequest";
import { LoginRequest } from "../models/LoginRequest";
import utils from "../lib/utils";
let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

// Resistration of a user
export async function register(request: RegisterRequest) {
	let conn = getConnection();

	if (request.userType.toLowerCase() == "educator") {
		let user = new Educator();
		user.email = request.email;
		user.firstName = request.firstName;
		user.lastName = request.lastName;
		user.organizationId = request.organizationId;

		const saltHAsh = utils.genPassword(request.password);
		user.salt = saltHAsh.salt;
		user.hash = saltHAsh.hash;

		let userRepo = conn.getRepository(Educator);

		return userRepo.save(user).then((result) => {
			statusRes.message = "User registered";
			statusRes.type = "success";
			return statusRes;
		});
	}
}

export async function login(request: LoginRequest) {}
