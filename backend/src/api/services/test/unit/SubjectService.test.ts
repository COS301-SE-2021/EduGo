import 'reflect-metadata';
import { Subject } from '../../../database/Subject';
import { Repository } from 'typeorm';
import { User } from '../../../database/User';
import { Organisation } from '../../../database/Organisation';
import { Educator } from '../../../database/Educator';
import { Student } from '../../../database/Student';
import { instance, mock } from 'ts-mockito';
import { SubjectService } from '../../SubjectService'; 

let mockedSubjectRepository: Repository<Subject> = mock(Repository)
let subjectRepository: Repository<Subject> = instance(mockedSubjectRepository);

let mockedUserRepository: Repository<User>;
let userRepository: Repository<User> = instance(mockedUserRepository);

let mockedOrganisationRepository: Repository<Organisation>;
let organisationRepository: Repository<Organisation> = instance(mockedOrganisationRepository);

let mockedEducatorRepository: Repository<Educator>;
let educatorRepository: Repository<Educator> = instance(mockedEducatorRepository);

let mockedStudentRepository: Repository<Student>;
let studentRepository: Repository<Student> = instance(mockedStudentRepository);

let subjectService: SubjectService = new SubjectService(
    subjectRepository, 
    userRepository, 
    organisationRepository, 
    educatorRepository, 
    studentRepository
);

describe('Subject Service', () => {
    
})