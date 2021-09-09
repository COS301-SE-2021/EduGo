import { LoginRequest } from '../api/models/auth/LoginRequest';
import { RegisterRequest } from '../api/models/auth/RegisterRequest';
import * as App from './App';
import request from 'supertest';
import * as Default from './Default';
import { anything, capture, reset, verify, when } from 'ts-mockito';

describe('Auth API tests', () => {
    beforeEach(() => {
        reset(App.mockedUserRepository);
        reset(App.mockedUnverifiedUserRepository);
    });

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

    describe('/POST /auth/register', () => {
        it('should successfully register a student and return a token', async () => {
            const req: RegisterRequest = new RegisterRequest();
            req.username = 'temp',
            req.password = 'password',
            req.user_firstName = 'firstName',
            req.user_lastName = 'lastName',
            req.user_email = 'verifiedStudent@edugo.com'

            when(App.mockedUserRepository.findOne(anything())).thenResolve(undefined);
            when(App.mockedUnverifiedUserRepository.findOne(anything())).thenResolve(Default.verifiedStudent);

            const response = await request(App.app)
                .post('/auth/register')
                .set('Accept', 'application/json')
                .send(req)
                .expect(200)
                .expect('Content-Type', /json/);

            verify(App.mockedUserRepository.save(anything())).once();
            const [arg] = capture(App.mockedUserRepository.save).last();

            expect(arg.username).toBe(req.username);
            expect(arg.student).toBeDefined();
            expect(arg.educator).toBeUndefined();
            expect(arg.hash).toBeDefined();
            expect(arg.salt).toBeDefined();

            expect(response.body).toBeDefined();
            expect(response.body).toBe('ok');
        });

        it('should successfully register an educator and return a token', async () => {
            const req: RegisterRequest = new RegisterRequest();
            req.username = 'temp',
            req.password = 'password',
            req.user_firstName = 'firstName',
            req.user_lastName = 'lastName',
            req.user_email = 'verifiedEducator@edugo.com'

            when(App.mockedUserRepository.findOne(anything())).thenResolve(undefined);
            when(App.mockedUnverifiedUserRepository.findOne(anything())).thenResolve(Default.verifiedEducator);

            const response = await request(App.app)
                .post('/auth/register')
                .set('Accept', 'application/json')
                .send(req)
                .expect(200)
                .expect('Content-Type', /json/);

            verify(App.mockedUserRepository.save(anything())).once();
            const [arg] = capture(App.mockedUserRepository.save).last();

            expect(arg.username).toBe(req.username);
            expect(arg.student).toBeUndefined();
            expect(arg.educator).toBeDefined();
            expect(arg.hash).toBeDefined();
            expect(arg.salt).toBeDefined();

            expect(response.body).toBeDefined();
            expect(response.body).toBe('ok');
        });

        it('should return a BadRequestError if the email already exists', async () => {
            const req: RegisterRequest = new RegisterRequest();
            req.username = 'temp',
            req.password = 'password',
            req.user_firstName = 'firstName',
            req.user_lastName = 'lastName',
            req.user_email = 'student@edugo.com'

            when(App.mockedUserRepository.findOne(anything())).thenResolve(Default.studentUser);
            when(App.mockedUnverifiedUserRepository.findOne(anything())).thenResolve(Default.verifiedStudent);

            const response = await request(App.app)
                .post('/auth/register')
                .set('Accept', 'application/json')
                .send(req)
                .expect(400)
                .expect('Content-Type', /json/);

            expect(response.body.message).toBeDefined();
            expect(response.body.message).toContain('mail already exists');

        });

        it('should return a BadRequestError if the username already exists', async () => {
            const req: RegisterRequest = new RegisterRequest();
            req.username = 'student',
            req.password = 'password',
            req.user_firstName = 'firstName',
            req.user_lastName = 'lastName',
            req.user_email = 'temp@edugo.com'

            when(App.mockedUserRepository.findOne(anything())).thenResolve(undefined).thenResolve(Default.studentUser);
            when(App.mockedUnverifiedUserRepository.findOne(anything())).thenResolve(Default.verifiedStudent);

            const response = await request(App.app)
                .post('/auth/register')
                .set('Accept', 'application/json')
                .send(req)
                .expect(400)
                .expect('Content-Type', /json/);

            expect(response.body.message).toBeDefined();
            expect(response.body.message).toContain('sername already exists');
        });

        it('should return a NotFoundError if the user has not been verified', async () => {
            const req: RegisterRequest = new RegisterRequest();
            req.username = 'temp',
            req.password = 'password',
            req.user_firstName = 'firstName',
            req.user_lastName = 'lastName',
            req.user_email = 'unverifiedStudent@edugo.com'

            when(App.mockedUserRepository.findOne(anything())).thenResolve(undefined);
            when(App.mockedUnverifiedUserRepository.findOne(anything())).thenResolve(Default.unverifiedStudent);

            const response = await request(App.app)
                .post('/auth/register')
                .set('Accept', 'application/json')
                .send(req)
                .expect(404)
                .expect('Content-Type', /json/);

            expect(response.body.message).toBeDefined();
            expect(response.body.message).toContain('ser');
            expect(response.body.message).toContain('not');
            expect(response.body.message).toContain('nvited');
        })
    });
})