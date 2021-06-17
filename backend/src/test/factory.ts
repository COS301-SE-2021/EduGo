import 'reflect-metadata';

process.env.NODE_ENV = 'test';

import dotenv from 'dotenv';
dotenv.config()

import { createConnection, Connection, ConnectionOptions } from 'typeorm'

class TestFactory {
    
}