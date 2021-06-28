import { ApiResponse } from "../../models/apiResponse";
import { Any, createConnection, getConnection } from "typeorm";
import { Educator } from "../../database/entity/Educator";
import { Student} from "../../database/entity/Student"
import { RegisterRequest } from "../models/registerRequest";
import { LoginRequest } from "../models/LoginRequest";
let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

// Resistration of a user 
export async function register(request: RegisterRequest) {
	let conn = getConnection();
	let user = (request.userType.toLowerCase()== "educator")
	?new Educator()
	:new Student()
	
	user.email = request.email; 
	user.firstName = request.firstName; 
	user.lastName = request.lastName; 
	user.organizationId = request.organizationId
	
}

export async function login(request: LoginRequest) {}
