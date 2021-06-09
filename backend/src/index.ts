import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import {Client} from 'pg';
import { dbInit } from './database/index';
import Container from 'typedi';
import 'reflect-metadata'
//dotenv.config();

// const client = new Client({
//     user: process.env.DB_USER,
//     host: 'db',
//     database: 'edugo',
//     password: process.env.DB_PASSWORD,
//     port: 5432
// });

// client.connect();

// export {client};

dbInit();



app.listen(PORT, () => console.log(`Server listening on port: ${PORT}`));