import express from 'express';

export class BadRequestError extends Error {
    constructor(message?: string) {
        super(message ?? 'Bad Request Error');
    }
}

export class InternalServerError extends Error {
    constructor(message?: string) {
        super(message ?? 'Internal Server Error');
    }
}

export class NotFoundError extends Error {
    constructor(message?: string) {
        super(message ?? 'Not Found Error');
    }
}

export const HandleResponse = (res: express.Response, err: any) => {
    if (err instanceof BadRequestError) {
        res.status(400).send(err.message);
    }
    else if (err instanceof InternalServerError) {
        res.status(500).send(err.message);
    }
    else if (err instanceof NotFoundError) {
        res.status(404).send(err.message);
    }
    else {
        res.status(500).json(err);
    }
}