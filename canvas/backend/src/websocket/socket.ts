import axios from 'axios';
import { plainToClass } from 'class-transformer';
import * as socket from 'socket.io';
import { io } from '../';
import { IdentifyEducatorRequest, IdentifyStudentRequest } from './models/Identify';

let activeRooms: any = {};
let userMap: any = {};

export const onConnection = (socket: socket.Socket) => {
    console.log(`New Connection: ${socket.id}`);

    socket.on('disconnect', disconnect.bind(this, socket));
    socket.on('identify_educator', identifyEducator.bind(this, socket));
    socket.on('identify_student', identifyStudent.bind(this, socket));
    //socket.on('new_ratio', new_ratio.bind(this, socket));
    socket.on('new_camera', new_camera.bind(this, socket));
    socket.on('set_link', set_link.bind(this, socket));
    socket.on('new_draw', new_draw.bind(this, socket));
    socket.on('clear_draw', clear_draw.bind(this, socket));
};

const identifyEducator = async (socket: socket.Socket, socket_data: any) => {
    let identity = plainToClass(IdentifyEducatorRequest, socket_data);
    if (identity.token == undefined) {
        socket.emit('declined', 'Missing token');
        return;
    }

    // if (identity.ratio == undefined) {
    //     socket.emit('declined', 'Missing ratio');
    //     return;
    // }

    let response = await axios.get(
        `${process.env.BACKEND}/user/getUserDetails`, 
        {headers: {authorization: `Bearer ${socket_data.token}`}}
    );

    if (response.status !== 200) {
        socket.emit('declined', `Code: ${response.status}`);
        return;
    }

    let {data} = response;
    if (!('userType' in data)) {
        socket.emit('declined', 'User not found');
        return;
    }

    if (data.userType === 'educator') {
        let code: string = '';
        while (true) {
            code = generateCode(4);
            if (!Object.keys(activeRooms).includes(code))
                break; 
        }

        activeRooms[code] = {};
        activeRooms[code]['educator'] = socket.id;
        activeRooms[code]['link'] = null;
        //activeRooms[code]['ratio'] = identity.ratio;
        socket.join(code);
        userMap[socket.id] = code;
        socket.emit('accepted_educator', {code: code});
        console.log(io.sockets.adapter.rooms);
    }
    else socket.emit('declined', 'Invalid user type');
}

const identifyStudent = async (socket: socket.Socket, socket_data: any) => {
    let identity = plainToClass(IdentifyStudentRequest, socket_data);
    if (identity.token == undefined) {
        socket.emit('declined', 'Missing token');
        return;
    }

    if (identity.code == undefined) {
        socket.emit('declined', 'Missing code');
        return;
    }

    let response = await axios.get(
        `${process.env.BACKEND}/user/getUserDetails`, 
        {headers: {authorization: `Bearer ${socket_data.token}`}}
    );

    if (response.status !== 200) {
        socket.emit('declined', `Code: ${response.status}`);
        return;
    }

    let {data} = response;
    if (!('userType' in data)) {
        socket.emit('declined', 'User not found');
        return;
    }

    console.log(data);

    if (data.userType === 'student') {
        if (Object.keys(activeRooms).includes(identity.code)) {
            socket.join(identity.code);
            userMap[socket.id] = identity.code;
            //socket.emit('accepted_student', {code: identity.code, link: activeRooms[identity.code]['link'], ratio: activeRooms[identity.code]['ratio']});
            socket.emit('accepted_student', {code: identity.code, link: activeRooms[identity.code]['link']});
        }
        else socket.emit('declined', 'Invalid code');
    }
    else socket.emit('declined', 'Invalid user type');
}

const disconnect = (socket: socket.Socket) => {
    console.log(`Disconnected: ${socket.id}`);
    let code = userMap[socket.id];
    if (activeRooms[code] && activeRooms[code]['educator'] === socket.id) {
        socket.to(code).emit('end');
        delete activeRooms[code];
    }
    delete userMap[socket.id];
}

const new_camera = (socket: socket.Socket, data: any) => {
    let code = userMap[socket.id];
    socket.to(code).emit('camera_updated', data)
}

const set_link = (socket: socket.Socket, data: any) => {
    let code = userMap[socket.id];
    activeRooms[code]['link'] = data.link;
}

// const new_ratio = (socket: socket.Socket, data: any) => {
//     let code = userMap[socket.id];
//     activeRooms[code]['ratio'] = data;
//     socket.to(code).emit('ratio_updated', data);
// }

const new_draw = (socket: socket.Socket, data: any) => {
    let code = userMap[socket.id];
    socket.to(code).emit('draw_updated', data);
}

const clear_draw = (socket: socket.Socket) => {
    let code = userMap[socket.id];
    socket.to(code).emit('clear_draw');
}

const generateCode = (length: number): string => {
    let charset = "0123456789";
    let result = "";
    for (let i = 0; i < length; i++)
        result += charset[Math.floor(Math.random() * charset.length)];
    return result;
}