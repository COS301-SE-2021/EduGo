import { Error400 } from "./Error";

export class InvalidParameterError extends Error400 {
    constructor(message: string) {
        super(message);
    }
}