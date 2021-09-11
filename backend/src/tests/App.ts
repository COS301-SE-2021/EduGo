import 'reflect-metadata';
import { Action, createExpressServer, useContainer as diUseContainer } from "routing-controllers";
import { LessonController } from "../api/controllers/lessonController";
import { OrganisationController } from "../api/controllers/OrganisationController";
import { SubjectController } from "../api/controllers/subjectController";
import { UserController } from "../api/controllers/userController";
import { VirtualEntityController } from "../api/controllers/virtualEntityController";
import { AuthController } from "../api/controllers/authController";
import { Container } from "typedi";
import { Connection, ConnectionManager, Repository, useContainer as ormUseContainer } from "typeorm";
import { anything, instance, mock, when } from "ts-mockito";
import { Lesson } from "../api/database/Lesson";
import { Subject } from "../api/database/Subject";
import { VirtualEntity } from "../api/database/VirtualEntity";
import { User } from "../api/database/User";
import { UnverifiedUser } from "../api/database/UnverifiedUser";
import { Organisation } from "../api/database/Organisation";
import { Student } from "../api/database/Student";
import { Educator } from "../api/database/Educator";
import { Grade } from "../api/database/Grade";
import { Quiz } from "../api/database/Quiz";
import express from "express";
import azureStorage from 'azure-storage';
import * as Default from "./Default";

Error.stackTraceLimit = Infinity;

let mockedConnectionManager: ConnectionManager = mock(ConnectionManager);
let connectionManagerInstance: ConnectionManager = instance(mockedConnectionManager);

let mockedConnection: Connection = mock(Connection);
let connectionInstance: Connection = instance(mockedConnection);

export let mockedEducatorRepository: Repository<Educator> = mock(Repository);
let educatorRepository: Repository<Educator> = instance(mockedEducatorRepository);

export let mockedGradeRepository: Repository<Grade> = mock(Repository);
let gradeRepository: Repository<Grade> = instance(mockedGradeRepository);

export let mockedLessonRepository: Repository<Lesson> = mock(Repository);
let lessonRepository: Repository<Lesson> = instance(mockedLessonRepository);

export let mockedOrganisationRepository: Repository<Organisation> = mock(Repository);
let organisationRepository: Repository<Organisation> = instance(mockedOrganisationRepository);

export let mockedQuizRepository: Repository<Quiz> = mock(Repository);
let quizRepository: Repository<Quiz> = instance(mockedQuizRepository);

export let mockedStudentRepository: Repository<Student> = mock(Repository);
let studentRepository: Repository<Student> = instance(mockedStudentRepository);

export let mockedSubjectRepository: Repository<Subject> = mock(Repository);
let subjectRepository: Repository<Subject> = instance(mockedSubjectRepository);

export let mockedUnverifiedUserRepository: Repository<UnverifiedUser> = mock(Repository);
let unverifiedUsersRepository: Repository<UnverifiedUser> = instance(mockedUnverifiedUserRepository);

export let mockedUserRepository: Repository<User> = mock(Repository);
let userRepository: Repository<User> = instance(mockedUserRepository);

export let mockedVirtualEntityRepository: Repository<VirtualEntity> = mock(Repository);
let virtualEntityRepository: Repository<VirtualEntity> = instance(mockedVirtualEntityRepository);

export let mockedAzureBlobService = mock(azureStorage.BlobService);
let azureBlobService = instance(mockedAzureBlobService);

when(mockedConnectionManager.has(anything())).thenReturn(true);
when(mockedConnectionManager.get(anything())).thenReturn(connectionInstance);
when(mockedConnection.getRepository(Educator)).thenReturn(educatorRepository);
when(mockedConnection.getRepository(Grade)).thenReturn(gradeRepository);
when(mockedConnection.getRepository(Lesson)).thenReturn(lessonRepository);
when(mockedConnection.getRepository(Organisation)).thenReturn(organisationRepository);
when(mockedConnection.getRepository(Quiz)).thenReturn(quizRepository);
when(mockedConnection.getRepository(Student)).thenReturn(studentRepository);
when(mockedConnection.getRepository(Subject)).thenReturn(subjectRepository);
when(mockedConnection.getRepository(UnverifiedUser)).thenReturn(unverifiedUsersRepository);
when(mockedConnection.getRepository(User)).thenReturn(userRepository);
when(mockedConnection.getRepository(VirtualEntity)).thenReturn(virtualEntityRepository);

Container.set(ConnectionManager, connectionManagerInstance);
Container.set(Repository, educatorRepository);
Container.set(Repository, gradeRepository);
Container.set(Repository, lessonRepository);
Container.set(Repository, organisationRepository);
Container.set(Repository, quizRepository);
Container.set(Repository, studentRepository);
Container.set(Repository, subjectRepository);
Container.set(Repository, unverifiedUsersRepository);
Container.set(Repository, userRepository);
Container.set(Repository, virtualEntityRepository);
Container.set(azureStorage.BlobService, azureBlobService);

diUseContainer(Container);
ormUseContainer(Container);

export const app: express.Express = createExpressServer({
    controllers: [
        AuthController,
        LessonController,
        OrganisationController,
        SubjectController,
        UserController,
        VirtualEntityController
    ],
    currentUserChecker: (action: Action) => action.request.user_id,
});