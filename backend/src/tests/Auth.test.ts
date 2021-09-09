import { LoginRequest } from '../api/models/auth/LoginRequest';
import * as App from './App';
import request from 'supertest';
import * as Default from './Default';
import { anything, when } from 'ts-mockito';
import { User } from '../api/database/User';

describe('Auth API tests', () => {
    describe('POST /auth/login', () => {
        it('should successfully login a student and return a token', async () => {
            const req: LoginRequest = {
                username: 'student',
                password: 'password'
            }

            when(App.mockedUserRepository.findOne(anything())).thenResolve(Default.studentUser);

            const response = await request(App.app)
                .post('/auth/login')
                .set('Accept', 'application/json')
                .send(req);

            console.log(response.body);
        })
    })
})