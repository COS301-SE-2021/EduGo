interface validationResult {
	ok: boolean;
	message: string;
}

const missing = (param: string): validationResult => {
	return { ok: false, message: `Missing param: ${param}` };
};

export const validateRegsisterRequest = (body: any): validationResult => {
	let keys = ["firstName", "lastName", "email", "organizationId"];
	for (let key of keys) {
		let body_keys = Object.keys(body);
		if (!body_keys.includes(key)) return missing(key);
	}
	return { ok: true, message: "" };
};
