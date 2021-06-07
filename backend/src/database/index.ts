import 'reflect-metadata';
import { createConnection } from 'typeorm'

export const dbInit = async () => {
    createConnection()
        .then(connection => {
            console.log('First database connection successful.');
            connection.close();
        })
        .catch(err => console.log(err))
}