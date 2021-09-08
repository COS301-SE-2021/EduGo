import 'reflect-metadata';
import { Subject } from '../../../database/Subject';
import { Repository } from 'typeorm';
import { User } from '../../../database/User';
import { Organisation } from '../../../database/Organisation';
import { Educator } from '../../../database/Educator';
import { Student } from '../../../database/Student';
import { anyNumber, anything, instance, mock, reset, when, verify, capture } from 'ts-mockito';
import { SubjectService } from '../../SubjectService'; 
import { users, organisation } from './Defaults';
import { CreateSubjectRequest } from '../../../models/subject/CreateSubjectRequest';
import { BadRequestError, NotFoundError } from 'routing-controllers';

let mockedSubjectRepository: Repository<Subject> = mock(Repository)
let subjectRepository: Repository<Subject> = instance(mockedSubjectRepository);

let mockedUserRepository: Repository<User> = mock(Repository);
let userRepository: Repository<User> = instance(mockedUserRepository);

let mockedOrganisationRepository: Repository<Organisation> = mock(Repository);
let organisationRepository: Repository<Organisation> = instance(mockedOrganisationRepository);

let mockedEducatorRepository: Repository<Educator> = mock(Repository);
let educatorRepository: Repository<Educator> = instance(mockedEducatorRepository);

let mockedStudentRepository: Repository<Student> = mock(Repository);
let studentRepository: Repository<Student> = instance(mockedStudentRepository);

let subjectService: SubjectService = new SubjectService(
    subjectRepository, 
    userRepository, 
    organisationRepository, 
    educatorRepository, 
    studentRepository
);

describe('Subject Service', () => {
    beforeEach(() => {
        reset(mockedSubjectRepository);
        reset(mockedUserRepository);
        reset(mockedOrganisationRepository);
        reset(mockedEducatorRepository);
        reset(mockedStudentRepository);
    });

    describe('Create Subject', () => {
        it.skip('should create a new subject', async () => {
            let request: CreateSubjectRequest = {
                title: 'Test Subject',
                grade: 12
            }

            let subject: Subject = new Subject();
            subject.title = request.title;
            subject.grade = request.grade;

            when(mockedUserRepository.findOne(anyNumber(), anything())).thenResolve(users[0]).thenResolve({...users[1], educator: {id: 1, admin: true, subjects: [], user: users[1]}});
            when(mockedOrganisationRepository.findOne(anyNumber())).thenResolve(organisation);
            when(mockedSubjectRepository.save(anything())).thenResolve({...subject, id: 1});

            let result = await subjectService.CreateSubject(request, 1, '');
            verify(mockedUserRepository.findOne(anyNumber(), anything())).twice();
            verify(mockedOrganisationRepository.findOne(anyNumber())).once();
            verify(mockedSubjectRepository.save(anything())).once();

            const [arg] = capture(mockedSubjectRepository.save).last();
            expect(arg.title).toBe(request.title);
            expect(arg.grade).toBe(request.grade);
            expect(result.id).toBe(1);
            expect(arg.id).toBe(1);

        });

        it('should throw a BadRequestError if the user found does not have an educator object', async () => {
            let request: CreateSubjectRequest = {
                title: 'Test Subject',
                grade: 12
            }

            let subject: Subject = new Subject();
            subject.title = request.title;
            subject.grade = request.grade;

            when(mockedUserRepository.findOne(anyNumber(), anything())).thenResolve(users[0]).thenResolve(users[1]);
            when(mockedOrganisationRepository.findOne(anyNumber())).thenResolve(organisation);

            expect(async () => await subjectService.CreateSubject(request, 1, '')).rejects.toThrow(BadRequestError);

        })
    });
})