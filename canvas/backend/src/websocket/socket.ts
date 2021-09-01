import { plainToClass } from 'class-transformer';
import { validate } from 'class-validator';
import * as socket from 'socket.io';
import { error } from './error';
import { Init } from './models/Init';
import { getUser, User } from './user/User';
import { io } from '../';

let students: User[] = [];
let educators: User[] = [];

export const onConnection = (socket: socket.Socket) => {
    socket.on('init', async (rawData: any) => {
        let data: Init = plainToClass(Init, rawData);
        let valid = await validate(data);
        if (valid.length > 0) {
            console.log('Invalid data');
            error(socket, 'Invalid data');
        }

        let user: User = await getUser(data.token);
        if (user.type === 'student') {
            students.push(user);
        }
        else if (user.type === 'educator') {
            educators.push(user);
        }
    });

    socket.on('new_camera', (data) => {
        console.log(data);
        io.emit('camera_updated', data);
    })

    socket.on('disconnect', () => {
        console.log('disconnected');
    });
    console.log('connected');
};