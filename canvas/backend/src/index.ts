import 'reflect-metadata';
import express from 'express';
import http from 'http';
import cors from 'cors';
import * as socket from 'socket.io';
import dotenv from 'dotenv';

dotenv.config();

const PORT = process.env.PORT || 8085;

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.set('port', PORT);

import { router as VirtualEntityRouter} from './api/VirtualEntityRouter';

app.use('/api', VirtualEntityRouter);

const server = http.createServer(app);

import { onConnection } from './websocket/socket';

export const io = new socket.Server(server, {
    cors: {
        origin: '*',
        methods: ["GET", "POST", "OPTIONS", "PATCH", "PUT", "DELETE", "HEAD"],
        allowedHeaders: ["*"]
    }
});
io.on('connection', onConnection);


server.listen(PORT, () => console.log(`Listening on port ${PORT}`));