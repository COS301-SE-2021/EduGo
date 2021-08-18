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
import { AnswerQuizRequest } from '../../../models/virtualEntity/AnswerQuizRequest';
import { TogglePublicRequest } from '../../../models/virtualEntity/TogglePublicRequest';
import { GetQuizesByLessonRequest } from '../../../models/virtualEntity/GetQuizesByLessonRequest';
import { Organisation } from '../../../database/Organisation';

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

let organisation: Organisation = new Organisation();
organisation.id = 1;

let studentUser: User = new User()
studentUser.id = 1
studentUser.firstName = 'Test'
studentUser.lastName = 'User'
studentUser.email = 'test@email.com'
studentUser.username = 'testUser'
studentUser.student = new Student();
studentUser.student.id = 1;
studentUser.student.subjects = [];
studentUser.organisation = organisation;

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
            id: 0
        }

        it('should successfully return a virtual entity', async () => {
            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;

            when(mockedVirtualEntityRepository.findOne(anything(), anything())).thenResolve(virtualEntity);

            let response = await virtualEntityController.GetVirtualEntity(request);
            expect(response.id).toBe(1);
            verify(mockedVirtualEntityRepository.findOne(anything(), anything())).once();
        })

        it('should throw an error if virtual entity does not exist', async () => {
            when(mockedVirtualEntityRepository.findOne(anything(), anything())).thenResolve(undefined);
            expect(() => virtualEntityController.GetVirtualEntity(request)).rejects.toThrow(NotFoundError);
        })
    })

    describe('Toggle Public', () => {
        let request: TogglePublicRequest = {
            id: 1
        }

        it('successfully make a private virtual entity public', async () => {
            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;
            virtualEntity.public = false;
            virtualEntity.organisation = organisation;

            when(mockedUserRepository.findOne(anything(), anything())).thenResolve(studentUser);
            when(mockedVirtualEntityRepository.findOne(anything(), anything())).thenResolve(virtualEntity);
            when(mockedVirtualEntityRepository.save(anything())).thenResolve(virtualEntity);

            let response = await virtualEntityController.TogglePublic(request, studentUser.id);
            expect(response.public).toBe(true);
            verify(mockedVirtualEntityRepository.findOne(anything(), anything())).once();
            verify(mockedVirtualEntityRepository.save(anything())).once();

            const [arg] = capture(mockedVirtualEntityRepository.save).last()
            expect(arg.public).toBe(true);
        });

        it('successfully make a public virtual entity private', async () => {
            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;
            virtualEntity.public = true;
            virtualEntity.organisation = organisation;

            when(mockedUserRepository.findOne(anything(), anything())).thenResolve(studentUser);
            when(mockedVirtualEntityRepository.findOne(anything(), anything())).thenResolve(virtualEntity);
            when(mockedVirtualEntityRepository.save(anything())).thenResolve(virtualEntity);

            let response = await virtualEntityController.TogglePublic(request, studentUser.id);
            expect(response.public).toBe(false);
            verify(mockedVirtualEntityRepository.findOne(anything(), anything())).once();
            verify(mockedVirtualEntityRepository.save(anything())).once();

            const [arg] = capture(mockedVirtualEntityRepository.save).last()
            expect(arg.public).toBe(false);
        })
    })

    describe('Get Public Virtual Entities', () => {
        it('should successfully return a list of public virtual entities', async () => {
            let virtualEntities: VirtualEntity[] = [1,2,3,4].map(id => {
                let virtualEntity: VirtualEntity = new VirtualEntity();
                virtualEntity.id = id;
                virtualEntity.public = true;
                return virtualEntity;
            });

            when(mockedVirtualEntityRepository.find(anything())).thenResolve(virtualEntities);

            let response = await virtualEntityController.GetPublicVirtualEntities();
            expect(response.length).toBe(4);
            expect(response[0].id).toBe(1);
            expect(response[1].id).toBe(2);
            expect(response[2].id).toBe(3);
            expect(response[3].id).toBe(4);
            verify(mockedVirtualEntityRepository.find(anything())).once();
        })
    })

    describe('Get Private Virtual Entities', () => {
        it('should successfully return a list of private virtual entities', async () => {
            let virtualEntities: VirtualEntity[] = [1,2,3,4].map(id => {
                let virtualEntity: VirtualEntity = new VirtualEntity();
                virtualEntity.id = id;
                virtualEntity.public = false;
                return virtualEntity;
            });

            when(mockedUserRepository.findOne(anything(), anything())).thenResolve(studentUser);
            when(mockedVirtualEntityRepository.find(anything())).thenResolve(virtualEntities);

            let response = await virtualEntityController.GetPrivateVirtualEntities(studentUser.id);
            expect(response.length).toBe(4);
            expect(response[0].id).toBe(1);
            expect(response[1].id).toBe(2);
            expect(response[2].id).toBe(3);
            expect(response[3].id).toBe(4);
            verify(mockedVirtualEntityRepository.find(anything())).once();
        })
    })

    describe('Get Quizzes By Lesson', () => {
        let request: GetQuizesByLessonRequest = {
            id: 1
        }

        it('should successfully return a list of quizzes', async () => {
            let virtualEntities: VirtualEntity[] = [1,2,3].map(id => {
                let virtualEntity: VirtualEntity = new VirtualEntity();
                virtualEntity.id = id;
                let quiz: Quiz = new Quiz();
                quiz.id = id;
                let questions: Question[] = [1,2].map(id => {
                    let question: Question = new Question();
                    question.id = id;
                    question.question = 'A Question';
                    return question;
                });
                quiz.questions = questions;
                virtualEntity.quiz = quiz;
                return virtualEntity;
            })

            let lesson: Lesson = new Lesson();
            lesson.id = 1;
            lesson.virtualEntities = virtualEntities;

            when(mockedLessonRepository.findOne(anything(), anything())).thenResolve(lesson);
            let response = await virtualEntityController.GetQuizesByLesson(request);

            expect(response.data.length).toBe(3);
            expect(response.data[0].questions.length).toBe(2);
            verify(mockedLessonRepository.findOne(anything(), anything())).once();
        });
    })
})