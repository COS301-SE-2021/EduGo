export class NonExistantItemError extends Error {
    constructor(message: string) {
        super(message);
    }
}