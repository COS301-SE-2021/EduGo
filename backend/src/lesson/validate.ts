interface validationResult {
	ok: boolean;
	message: string;
}

const missing = (param: string): validationResult => {
	return { ok: false, message: `Missing param: ${param}` };
};

export const validateCreatelessRequest = (body: any): validationResult => {
	let keys = ["subjectId", "title", "description", "date"];
	for (let key of keys) {
		let body_keys = Object.keys(body);
		if (!body_keys.includes(key)) return missing(key);
	}
	return { ok: true, message: "" };
};
