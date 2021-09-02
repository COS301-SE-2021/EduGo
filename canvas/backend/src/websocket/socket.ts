import axios from 'axios';
import * as socket from 'socket.io';
import { io } from '../';

let activeRooms: string[] = [];
let userMap: any = {};

export const onConnection = (socket: socket.Socket) => {
    console.log(`New Connection: ${socket.id}`);

    socket.on('disconnect', disconnect.bind(this, socket));
    socket.on('identify', identify.bind(this, socket));
    socket.on('new_camera', new_camera.bind(this, socket));

    // socket.on('new_camera', (data) => {
    //     io.emit('camera_updated', data);
    // })

};

/*
 *  Data {
 *     token: string;
 *     code: string; <-- for student only
 *  }
 */
const identify = async (socket: socket.Socket, data: any) => {
    console.log(`Identify: ${socket.id}`);

    let userResponse = await axios.get(
        `${process.env.BACKEND}/user/getUserDetails`, 
        {headers: {authorization: `Bearer ${data.token}`}}
    );

    if (userResponse.status === 200) {
        let {data: userData} = userResponse;
        if ('userType' in userData) {
            if (userData.userType === 'educator') {
                let code: string = '';
                while (true) {
                    code = generateCode(4);
                    if (!activeRooms.includes(code))
                        break; 
                }
                activeRooms.push(code);
                socket.join(code);
                userMap[socket.id] = code;
                socket.emit('accepted', {code: code});
            }
            else if (userData.userType === 'student' && 'code' in data) {
                if (activeRooms.includes(data.code)) {
                    socket.join(data.code);
                    userMap[socket.id] = data.code;
                    socket.emit('accepted', {code: data.code});
                }
                else socket.emit('declined', 'Invalid code');
            }
            else {
                socket.emit('declined', 'No code given');
            }
        }
        else {
            socket.emit('declined', 'User not found');
        }
    }
    else {
        socket.emit('declined', `Code: ${userResponse.status}`);
    }
}

const disconnect = (socket: socket.Socket) => {
    console.log(`Disconnected: ${socket.id}`);
}

const new_camera = (socket: socket.Socket, data: any) => {
    let code = userMap[socket.id];
    socket.to(code).emit('camera_updated', data)
}

const generateCode = (length: number): string => {
    let charset = "0123456789";
    let result = "";
    for (let i = 0; i < length; i++)
        result += charset[Math.floor(Math.random() * charset.length)];
    return result;
}