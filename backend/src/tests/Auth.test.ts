import { LoginRequest } from '../api/models/auth/LoginRequest';
import * as App from './App';
import request from 'supertest';
import * as Default from './Default';
import { anything, when } from 'ts-mockito';

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
                .send(req)
                .expect(200)
                .expect('Content-Type', /json/);

            expect(response.body.token).toBeDefined();
        });

        it('should successfully login an educator and return a token', async () => {
            const req: LoginRequest = {
                username: 'educator',
                password: 'password'
            }

            when(App.mockedUserRepository.findOne(anything())).thenResolve(Default.educatorUser);

            const response = await request(App.app)
                .post('/auth/login')
                .set('Accept', 'application/json')
                .send(req)
                .expect(200)
                .expect('Content-Type', /json/);

            expect(response.body.token).toBeDefined();
        });

        it('should successfully login an admin and return a token, async', async () => {
            const req: LoginRequest = {
                username: 'admin',
                password: 'password'
            }

            when(App.mockedUserRepository.findOne(anything())).thenResolve(Default.adminUser);

            const response = await request(App.app)
                .post('/auth/login')
                .set('Accept', 'application/json')
                .send(req)
                .expect(200)
                .expect('Content-Type', /json/);

            expect(response.body.token).toBeDefined();
        });

        it('should return an Unauthorized error if a student username is not found and a message stating the username was nout found', async () => {
            const req: LoginRequest = {
                username: 'student',
                password: 'password'
            }

            when(App.mockedUserRepository.findOne(anything())).thenResolve(undefined);

            const response = await request(App.app)
                .post('/auth/login')
                .set('Accept', 'application/json')
                .send(req)
                .expect(401)
                .expect('Content-Type', /json/);

            expect(response.body.message).toBeDefined();
            expect(response.body.message).toContain('username');
            expect(response.body.message).toContain('not found');
        });

        it('should return an Unauthorized error if a student password is incorrect and a message stating the password was incorrect', async () => {
            const req: LoginRequest = {
                username: 'student',
                password: 'wrongpassword'
            }

            when(App.mockedUserRepository.findOne(anything())).thenResolve(Default.studentUser);

            const response = await request(App.app)
                .post('/auth/login')
                .set('Accept', 'application/json')
                .send(req)
                .expect(401)
                .expect('Content-Type', /json/);

            expect(response.body.message).toBeDefined();
            expect(response.body.message).toContain('assword');
            expect(response.body.message).toContain('ncorrect');
        });

        it('should return an Unauthorized error if an educator username is not found and a message stating the username was nout found', async () => {
            const req: LoginRequest = {
                username: 'educator',
                password: 'password'
            }

            when(App.mockedUserRepository.findOne(anything())).thenResolve(undefined);

            const response = await request(App.app)
                .post('/auth/login')
                .set('Accept', 'application/json')
                .send(req)
                .expect(401)
                .expect('Content-Type', /json/);

            expect(response.body.message).toBeDefined();
            expect(response.body.message).toContain('username');
            expect(response.body.message).toContain('not found');
        });

        it('should return an Unauthorized error if an educator password is incorrect and a message stating the password was incorrect', async () => {
            const req: LoginRequest = {
                username: 'educator',
                password: 'wrongpassword'
            }

            when(App.mockedUserRepository.findOne(anything())).thenResolve(Default.educatorUser);

            const response = await request(App.app)
                .post('/auth/login')
                .set('Accept', 'application/json')
                .send(req)
                .expect(401)
                .expect('Content-Type', /json/);

            expect(response.body.message).toBeDefined();
            expect(response.body.message).toContain('assword');
            expect(response.body.message).toContain('ncorrect');
        });

        it('should return an Unauthorized error if an admin username is not found and a message stating the username was nout found', async () => {
            const req: LoginRequest = {
                username: 'admin',
                password: 'password'
            }

            when(App.mockedUserRepository.findOne(anything())).thenResolve(undefined);

            const response = await request(App.app)
                .post('/auth/login')
                .set('Accept', 'application/json')
                .send(req)
                .expect(401)
                .expect('Content-Type', /json/);

            expect(response.body.message).toBeDefined();
            expect(response.body.message).toContain('username');
            expect(response.body.message).toContain('not found');
        });

        it('should return an Unauthorized error if an admin password is incorrect and a message stating the password was incorrect', async () => {
            const req: LoginRequest = {
                username: 'admin',
                password: 'wrongpassword'
            }

            when(App.mockedUserRepository.findOne(anything())).thenResolve(Default.adminUser);

            const response = await request(App.app)
                .post('/auth/login')
                .set('Accept', 'application/json')
                .send(req)
                .expect(401)
                .expect('Content-Type', /json/);

            expect(response.body.message).toBeDefined();
            expect(response.body.message).toContain('assword');
            expect(response.body.message).toContain('ncorrect');
        });
    });
})