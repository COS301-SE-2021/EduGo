import { ApiResponse } from "../../models/apiResponse";
import { Lesson } from "../../database/entity/Lesson";
import { Any, createConnection, getConnection } from "typeorm";
import { Subject } from "../../database/entity/Subject";

let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

export async function register() {
	
}

export async function login() {
	
}
