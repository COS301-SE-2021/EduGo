import { Error403 } from "./Error";

export class DatabaseError extends Error403 {
    constructor(message?: string) {
        super(message || 'There was a database error');
    }
}