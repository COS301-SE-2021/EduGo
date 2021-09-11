import * as socket from 'socket.io';

export const error = (socket: socket.Socket, error: any) => {
    socket.emit('error', error);
};