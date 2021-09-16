import { missing, invalid } from "../../../api/helper/ValidationHelper";

interface validationResult {
	ok: boolean;
	message: string;
}

export const validateCreateVirtualEntityRequest = (
	body: any
): validationResult => {
	const keys = ["title", "description"];
	const model_keys = [
		"name",
		"file_link",
		"file_size",
		"file_name",
		"file_type",
	];
	const quiz_keys = ["title", "description"];
	const question_keys = ["type", "question"];

	const body_keys = Object.keys(body);
	for (const key of keys) {
		if (!body_keys.includes(key)) return missing(key);
	}

	if ("model" in body) {
		const body_keys = Object.keys(body.model);
		for (const key of model_keys) {
			if (!body_keys.includes(key)) return missing(`model.${key}`);
		}
	}

	if ("quiz" in body) {
		const body_keys = Object.keys(body.quiz);
		for (const key of quiz_keys) {
			if (!body_keys.includes(key)) return missing(`quiz.${key}`);
		}
	}

	if (
		"quiz" in body &&
		"questions" in body.quiz &&
		body.quiz.questions instanceof Array &&
		body.quiz.questions.length > 0
	) {
		for (const question of body.quiz.questions) {
			const body_keys = Object.keys(question);
			for (const key of question_keys) {
				if (!body_keys.includes(key)) return missing(`question.${key}`);
			}
		}
	}

	return { ok: true, message: "" };
};

export const validateAddModelToVirtualEntityRequest = (
	body: any
): validationResult => {
	const keys = ["virtualEntity_id", "name", "description"];

	const body_keys = Object.keys(keys);
	for (const key of keys) {
		if (!body_keys.includes(key)) return missing(key);
	}

	if (typeof body.virtualEntity_id !== "number" || body.virtualEntity_id <= 0)
		return invalid("virtualEntity_id");

	return { ok: true, message: "" };
};

export const validateGetVirtualEntityRequest = (
	body: any
): validationResult => {
	const keys = ["id"];

	const body_keys = Object.keys(body);
	for (const key of keys) if (!body_keys.includes(key)) return missing(key);

	if (typeof body.id !== "number" || body.id <= 0) return invalid("id");

	return { ok: true, message: "" };
};
