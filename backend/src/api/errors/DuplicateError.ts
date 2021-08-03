import { Error403 } from "./Error";

export class DuplicateError extends Error403 {
    constructor(message: string) {
        super(message)
    }
}