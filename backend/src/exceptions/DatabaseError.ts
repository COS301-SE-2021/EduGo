export class DatabaseError extends Error {
    constructor(message?: string) {
        super(message || 'There was a database error');
    }
}