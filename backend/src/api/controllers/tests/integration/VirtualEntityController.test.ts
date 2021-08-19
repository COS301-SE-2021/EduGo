import 'reflect-metadata';
import { VirtualEntity } from '../../../database/VirtualEntity';
import { Student } from '../../../database/Student';
import { User } from '../../../database/User';
import { Question } from '../../../database/Question';
import { Quiz } from '../../../database/Quiz';
import { Lesson } from '../../../database/Lesson';
import { mock, instance, when, reset, anything, verify, capture } from 'ts-mockito';
import { Repository } from 'typeorm';
import { VirtualEntityService } from '../../../services/VirtualEntityService';
import { VirtualEntityController } from '../../virtualEntityController';
import { CreateVirtualEntityRequest } from '../../../models/virtualEntity/CreateVirtualEntityRequest';
import { InternalServerError, NotFoundError } from 'routing-controllers';
import { GetVirtualEntityRequest } from '../../../models/virtualEntity/GetVirtualEntityRequest';
import { Model } from '../../../database/Model';
import { GVE_Model } from '../../../models/virtualEntity/GetVirtualEntityResponse';
import { GVE_Quiz } from '../../../models/virtualEntity/GetVirtualEntityResponse';

let mockedVirtualEntityRepository: Repository<VirtualEntity> = mock(Repository);
let virtualEntityRepository: Repository<VirtualEntity> = instance(mockedVirtualEntityRepository);

let mockedQuizRepository: Repository<Quiz> = mock(Repository);
let quizRepository: Repository<Quiz> = instance(mockedQuizRepository);

let mockedQuestionRepository: Repository<Question> = mock(Repository);
let questionRepository: Repository<Question> = instance(mockedQuestionRepository);

let mockedUserRepository: Repository<User> = mock(Repository);
let userRepository: Repository<User> = instance(mockedUserRepository);

let mockedStudentRepository: Repository<Student> = mock(Repository);
let studentRepository: Repository<Student> = instance(mockedStudentRepository);

let mockedLessonRepository: Repository<Lesson> = mock(Repository);
let lessonRepository: Repository<Lesson> = instance(mockedLessonRepository);

let virtualEntityService: VirtualEntityService = new VirtualEntityService(
    virtualEntityRepository,
    quizRepository,
    questionRepository,
    userRepository,
    studentRepository,
    lessonRepository
);

let virtualEntityController: VirtualEntityController = new VirtualEntityController(virtualEntityService);

let studentUser: User = new User()
studentUser.id = 1
studentUser.firstName = 'Test'
studentUser.lastName = 'User'
studentUser.email = 'test@email.com'
studentUser.username = 'testUser'
studentUser.student = new Student();
studentUser.student.id = 1;
studentUser.student.subjects = [];

describe('Virtual Entity controller integration tests', () => {
    beforeEach(() => {
        reset(mockedVirtualEntityRepository);
        reset(mockedQuizRepository);
        reset(mockedQuestionRepository);
        reset(mockedUserRepository);
        reset(mockedStudentRepository);
        reset(mockedLessonRepository);

        when(mockedUserRepository.findOne(anything(), anything())).thenResolve(studentUser);
        when(mockedUserRepository.findOne(anything())).thenResolve(studentUser);
    });

    describe('Create Virtual Entity', () => {
        let request: CreateVirtualEntityRequest = {
            title: 'A Virtual Entity',
            description: 'A Virtual Entity Description',
            public: true,
            quiz: {
                questions: [
                    {
                        question: 'A Question',
                        correctAnswer: 'A Correct Answer',
                        options: ['A', 'B', 'C', 'D'],
                        type: 'TrueFalse'
                    }
                ]
            }
        }

        it('should successfully create a new virtual entity', async () => {
            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;

            when(mockedVirtualEntityRepository.save(anything())).thenResolve(virtualEntity);

            let response = await virtualEntityController.CreateVirtualEntity(request, studentUser.id);
            expect(response.id).toBe(1);
            verify(mockedVirtualEntityRepository.save(anything())).once();

            const [arg] = capture(mockedVirtualEntityRepository.save).last()
            expect(arg).toBeInstanceOf(VirtualEntity);
            expect(arg.quiz).toBeInstanceOf(Quiz);
            expect(arg.quiz!.questions![0]).toBeInstanceOf(Question);
            expect(arg.title).toBe('A Virtual Entity');
            expect(arg.quiz!.questions![0].question).toBe('A Question');
        });

        it('should throw a save error when unsuccessfully creating a new virtual entity', async () => {
            when(mockedVirtualEntityRepository.save(anything())).thenReject(new Error('Some Error'));
            expect(() => virtualEntityController.CreateVirtualEntity(request, studentUser.id)).rejects.toThrow(InternalServerError);
        })
    })

    describe('Get Virtual Entity', () => {
        let request: GetVirtualEntityRequest = {
            id: 1
        }

        it('should successfully get a virtual entity', async () => {
            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;
            virtualEntity.title = 'A Virtual Entity';
            virtualEntity.description = 'A Virtual Entity Description';
            when(mockedVirtualEntityRepository.findOne(anything(), anything())).thenResolve(virtualEntity);

            let response = await virtualEntityController.GetVirtualEntity(request);
            expect(response.id).toBe(1);
            expect(response.title).toBe('A Virtual Entity');
            expect(response.description).toBe('A Virtual Entity Description');
            verify(mockedVirtualEntityRepository.findOne(anything(), anything())).once();
        });

        it('should throw a not found error when unsuccessfully getting a virtual entity', async () => {
            when(mockedVirtualEntityRepository.findOne(anything(), anything())).thenReject(new Error('Some Error'));
            expect(() => virtualEntityController.GetVirtualEntity(request)).rejects.toThrow(NotFoundError);
        })

        it('should throw a not found error when getting a virtual entity returns undefined', async () => {
            when(mockedVirtualEntityRepository.findOne(anything(), anything())).thenResolve(undefined);
            expect(() => virtualEntityController.GetVirtualEntity(request)).rejects.toThrow(NotFoundError);
        });

        it('should successfully get a virtual entity with a model and quiz', async () => {
            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;
            virtualEntity.title = 'A Virtual Entity';
            virtualEntity.description = 'A Virtual Entity Description';
            virtualEntity.model = new Model();
            virtualEntity.model.id = 1;
            virtualEntity.model.name = 'A Model';
            virtualEntity.model.description = 'A Model Description';
            virtualEntity.quiz = new Quiz();
            virtualEntity.quiz.id = 1;
            virtualEntity.quiz.questions = [];

            when(mockedVirtualEntityRepository.findOne(anything(), anything())).thenResolve(virtualEntity);

            let response = await virtualEntityController.GetVirtualEntity(request);
            expect(response.id).toBe(1);
            expect(response.title).toBe('A Virtual Entity');
            expect(response.description).toBe('A Virtual Entity Description');
            expect(response.model).toBeDefined();
            expect(response.quiz).toBeDefined();
            verify(mockedVirtualEntityRepository.findOne(anything(), anything())).once();
        })
    })
})