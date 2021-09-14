import "reflect-metadata";
import {
	Action,
	createExpressServer,
	useContainer as diUseContainer,
} from "routing-controllers";
import { LessonController } from "../api/controllers/lessonController";
import { OrganisationController } from "../api/controllers/OrganisationController";
import { SubjectController } from "../api/controllers/subjectController";
import { UserController } from "../api/controllers/userController";
import { VirtualEntityController } from "../api/controllers/virtualEntityController";
import { AuthController } from "../api/controllers/authController";
import { Container } from "typedi";
import {
	Connection,
	ConnectionManager,
	Repository,
	useContainer as ormUseContainer,
} from "typeorm";
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
import azureStorage from "azure-storage";
import * as Default from "./Default";

Error.stackTraceLimit = Infinity;

const mockedConnectionManager: ConnectionManager = mock(ConnectionManager);
const connectionManagerInstance: ConnectionManager = instance(
	mockedConnectionManager
);

const mockedConnection: Connection = mock(Connection);
const connectionInstance: Connection = instance(mockedConnection);

export const mockedEducatorRepository: Repository<Educator> = mock(Repository);
const educatorRepository: Repository<Educator> = instance(
	mockedEducatorRepository
);

export const mockedGradeRepository: Repository<Grade> = mock(Repository);
const gradeRepository: Repository<Grade> = instance(mockedGradeRepository);

export const mockedLessonRepository: Repository<Lesson> = mock(Repository);
const lessonRepository: Repository<Lesson> = instance(mockedLessonRepository);

export const mockedOrganisationRepository: Repository<Organisation> =
	mock(Repository);
const organisationRepository: Repository<Organisation> = instance(
	mockedOrganisationRepository
);

export const mockedQuizRepository: Repository<Quiz> = mock(Repository);
const quizRepository: Repository<Quiz> = instance(mockedQuizRepository);

export const mockedStudentRepository: Repository<Student> = mock(Repository);
const studentRepository: Repository<Student> = instance(
	mockedStudentRepository
);

export const mockedSubjectRepository: Repository<Subject> = mock(Repository);
const subjectRepository: Repository<Subject> = instance(
	mockedSubjectRepository
);

export const mockedUnverifiedUserRepository: Repository<UnverifiedUser> =
	mock(Repository);
const unverifiedUsersRepository: Repository<UnverifiedUser> = instance(
	mockedUnverifiedUserRepository
);

export const mockedUserRepository: Repository<User> = mock(Repository);
const userRepository: Repository<User> = instance(mockedUserRepository);

export const mockedVirtualEntityRepository: Repository<VirtualEntity> =
	mock(Repository);
const virtualEntityRepository: Repository<VirtualEntity> = instance(
	mockedVirtualEntityRepository
);

export const mockedAzureBlobService = mock(azureStorage.BlobService);
const azureBlobService = instance(mockedAzureBlobService);

when(mockedConnectionManager.has(anything())).thenReturn(true);
when(mockedConnectionManager.get(anything())).thenReturn(connectionInstance);
when(mockedConnection.getRepository(Educator)).thenReturn(educatorRepository);
when(mockedConnection.getRepository(Grade)).thenReturn(gradeRepository);
when(mockedConnection.getRepository(Lesson)).thenReturn(lessonRepository);
when(mockedConnection.getRepository(Organisation)).thenReturn(
	organisationRepository
);
when(mockedConnection.getRepository(Quiz)).thenReturn(quizRepository);
when(mockedConnection.getRepository(Student)).thenReturn(studentRepository);
when(mockedConnection.getRepository(Subject)).thenReturn(subjectRepository);
when(mockedConnection.getRepository(UnverifiedUser)).thenReturn(
	unverifiedUsersRepository
);
when(mockedConnection.getRepository(User)).thenReturn(userRepository);
when(mockedConnection.getRepository(VirtualEntity)).thenReturn(
	virtualEntityRepository
);

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
		VirtualEntityController,
	],
	currentUserChecker: (action: Action) => action.request.user_id,
});
