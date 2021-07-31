import { Error403 } from "./Error";

export class EmailError extends Error403 {
    constructor(message: string) {
        super(message)
    }
}