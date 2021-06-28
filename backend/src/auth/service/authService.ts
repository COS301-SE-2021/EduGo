import { ApiResponse } from "../../models/apiResponse";
import { Lesson } from "../../database/entity/Lesson";
import { Any, createConnection, getConnection } from "typeorm";
import { Subject } from "../../database/entity/Subject";
import { Educator } from "../../database/entity/Educator";
import { Student } from "../../database/entity/Student";
import utils from "../lib/utils";
import { RegisterRequest } from "../models/RegisterRequest";

let statusRes: any = {
	message: "",
	type: "fail",
	token: null,
};

export async function register(request: RegisterRequest) {
	let conn = getConnection();
	// registration for a student
	if (request.userType.toLowerCase() == "educator") {
		let user = new Educator();
		user.email = request.email;
		user.firstName = request.firstName;
		user.lastName = request.lastName;
		user.username = request.username;
		user.organizationId = request.organizationId;
		user.verified = false;
		const saltHAsh = utils.genPassword(request.password);
		user.salt = saltHAsh.salt;
		user.hash = saltHAsh.hash;

		user.admin = false;
		let userRepo = conn.getRepository(Educator);

		return userRepo.save(user).then((result) => {
			let isValid = utils.validPassword(
				request.password,
				user.hash,
				user.salt
			);
			if (isValid) {
				statusRes.token = utils.issueJWT(user);
				statusRes.message = "Educator registered";
				statusRes.type = "success";
			}

			return statusRes;
		});
	} else {
		// registration for an educator
		let user = new Student();
		user.email = request.email;
		user.firstName = request.firstName;
		user.lastName = request.lastName;
		user.username = request.username;
		user.organizationId = request.organizationId;
		user.verified = false;
		const saltHAsh = utils.genPassword(request.password);
		user.salt = saltHAsh.salt;
		user.hash = saltHAsh.hash;

		let userRepo = conn.getRepository(Student);

		return userRepo.save(user).then((result) => {
			statusRes.message = "Student registered";
			statusRes.type = "success";
			return statusRes;
		});
	}
}

export async function login() {}
