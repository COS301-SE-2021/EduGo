import { ApiResponse } from "../../models/apiResponse";
import { Lesson } from "../../database/entity/Lesson";
import { Any, createConnection, getConnection } from "typeorm";
import { Subject } from "../../database/entity/Subject";
import { Educator } from "../../database/entity/Educator";
import utils from "../lib/utils";
import { RegisterRequest } from "../models/RegisterRequest";

let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

export async function register(request: RegisterRequest) {
	let conn = getConnection();

	if (request.userType.toLowerCase() == "educator") {
		let user = new Educator();
		user.email = request.email;
		user.firstName = request.firstName;
		user.lastName = request.lastName;
		user.organizationId = request.organizationId;
		user.verified = false;
		const saltHAsh = utils.genPassword(request.password);
		user.salt = saltHAsh.salt;
		user.hash = saltHAsh.hash;
		user.admin = false;
		let userRepo = conn.getRepository(Educator);

		return userRepo.save(user).then((result) => {
			statusRes.message = "User registered";
			statusRes.type = "success";
			return statusRes;
		});
	}
}

export async function login() {}
