import axios from "axios";

type userType = 'student' | 'educator';

export class User {
    type: userType;
    token: string;
}

export const getUser = async (token: string) => {
    let response = await axios.get(`${process.env.MAIN_BACKEND_URL}/user/getUserDetails`, {headers: {authorization: `Bearer ${token}`}});

    if (response.status === 200) {
        if ('userType' in response.data) {
            let user = new User();
            user.type = response.data as userType;
            user.token = token;
            return user;
        }
        throw new Error('User type not established')
    }
    else throw new Error('Bad Request');
}