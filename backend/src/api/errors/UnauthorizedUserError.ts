import { Error401 } from "./Error";

export class UnauthorizedUserError extends Error401{
    constructor(message: string) {
        super(message);
    }
}