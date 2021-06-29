import { ApiResponse } from "../../models/apiResponse";
import { Any, createConnection, getConnection } from "typeorm";
import { Educator } from "../../database/entity/Educator";
import { Student } from "../../database/entity/Student";
import { RegisterRequest } from "../models/registerRequest";
import utils from "../lib/utils";
let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

// To Do
export async function makeUserAdmin(request: RegisterRequest) {}
