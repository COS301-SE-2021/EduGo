import * as socket from 'socket.io';

export const onConnection = (socket: socket.Socket) => {
    socket.on('message', (data) => {
        console.log(data);
    });
    console.log('connected');
};