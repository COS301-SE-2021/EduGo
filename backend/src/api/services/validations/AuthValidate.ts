import { validationResult } from "../../helper/ValidationHelper";
import { missing, invalid } from "../../../api/helper/ValidationHelper";
import { InvalidParameterError } from "../../errors/InvalidParametersError";

export const validateRegisterRequest = (body: any): validationResult => {
	let keys = [
		"user_email",
		"user_firstName",
		"user_lastName",
		"username",
		"userType",
		"password",
		"organisation_id",
	];

	let body_keys = Object.keys(body);
	for (let key of keys) {
		if (!body_keys.includes(key))
			throw new InvalidParameterError(`Parameter is missing ${key}`);
	}

	return { ok: true, message: "" };
};
