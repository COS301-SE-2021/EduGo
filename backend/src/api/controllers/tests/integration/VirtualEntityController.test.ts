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
import { InternalServerError } from 'routing-controllers';

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
})