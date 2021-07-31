import { Error400 } from "./Error";

export class NonExistantItemError extends Error400 {
    constructor(message: string) {
        super(message);
    }
}