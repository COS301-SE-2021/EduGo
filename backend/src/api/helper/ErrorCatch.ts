import { Error400, Error401, Error403 } from "../errors/Error";
import { Response } from "express";

export function handleErrors(error: any, res: Response) {
	if (error instanceof Error400) {
		res.status(400).json(error);
	} else if (error instanceof Error401) {
		res.status(401).json(error);
	} else if (error instanceof Error403) {
		res.status(403).json(error);
	} else res.status(500).json(error);
}
