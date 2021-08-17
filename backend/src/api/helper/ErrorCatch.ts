import { ForbiddenError } from "routing-controllers";

export function handleSavetoDBErrors(err: any) {
	if (err.code == "23505") {
		throw new ForbiddenError(err.detail);
	} else throw err;
}
