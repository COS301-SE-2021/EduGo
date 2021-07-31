export interface validationResult {
	ok: boolean;
	message: string;
}

export const missing = (param: string): validationResult => {
	return { ok: false, message: `Missing param: ${param}` };
};

export const invalid = (param: string): validationResult => {
	return { ok: false, message: `Invalid param: ${param}` };
};
