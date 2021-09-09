import { User } from "../api/database/User";
import { Organisation } from "../api/database/Organisation";
import { Subject } from "../api/database/Subject";
import { Lesson } from "../api/database/Lesson";
import { VirtualEntity } from "../api/database/VirtualEntity";
import { Question, QuestionType } from "../api/database/Question";

export const eduGoOrg = new Organisation();
eduGoOrg.id = 1;
eduGoOrg.name = "EduGo";
eduGoOrg.email = "edugo@edugo.com";
eduGoOrg.phone = "1234567890";
eduGoOrg.subjects = [];
eduGoOrg.users = [];
eduGoOrg.unverifiedUsers = [];
eduGoOrg.virtualEntities = [];

export const adminUser = new User();
adminUser.id = 1;
adminUser.username = "admin";
adminUser.email = "admin@edugo.com";
adminUser.firstName = "Admin";
adminUser.lastName = "EduGo";
adminUser.educator = {
    admin: true,
    id: 1,
    subjects: [],
    user: adminUser
}
adminUser.organisation = eduGoOrg;
eduGoOrg.users.push(adminUser);

export const educatorUser = new User();
educatorUser.id = 2;
educatorUser.username = "educator";
educatorUser.email = "educator@edugo.com";
educatorUser.firstName = "Educator";
educatorUser.lastName = "EduGo";
educatorUser.educator = {
    admin: false,
    id: 2,
    subjects: [],
    user: educatorUser
}
educatorUser.organisation = eduGoOrg;
eduGoOrg.users.push(educatorUser);

export const studentUser = new User();
studentUser.id = 3;
studentUser.username = "student";
studentUser.email = "student@edugo.com";
studentUser.firstName = "Student";
studentUser.lastName = "EduGo";
studentUser.student = {
    id: 3,
    grades: [],
    subjects: [],
    user: studentUser
}
studentUser.organisation = eduGoOrg;
eduGoOrg.users.push(studentUser);

let lessons: Lesson[] = [];

export const subjects = [1, 2, 3, 4].map((id) => {
    let subject = new Subject();
    subject.id = id;
    subject.title = `Test Subject ${id}`;
    subject.grade = 12;
    subject.image = '';
    subject.organisation = eduGoOrg;
    subject.educators = [educatorUser.educator];
    subject.students = [studentUser.student];
    subject.unverifiedUsers = [];
    subject.lessons = [1, 2, 3].map(id => {
        let lesson = new Lesson();
        let computedId = id + ((subject.id - 1) * 3);
        lesson.id = computedId;
        lesson.title = `Test Lesson ${computedId}`;
        lesson.description = `Test Description ${computedId}`;
        lesson.subject = subject;
        lesson.grades = [];
        lesson.virtualEntities = [];
        lessons.push(lesson);
        return lesson;
    })
    return subject;
});
eduGoOrg.subjects = subjects;

export const virtualEntities = [1, 2, 3].map(id => {
    let virtualEntity = new VirtualEntity();
    virtualEntity.id = id;
    virtualEntity.title = `Test Virtual Entity ${id}`;
    virtualEntity.description = `Test Description ${id}`;
    virtualEntity.model = {
        id: id,
        name: `Test Model ${id}`,
        description: `Test Description ${id}`,
        file_name: `Test File Name ${id}`,
        file_link: `http://edugo.com`,
        file_type: `glb`,
        file_size: 12345,
    };
    virtualEntity.quiz = {
        id: id,
        grades: [],
        virtualEntity: virtualEntity,
        questions: [1, 2, 3].map(id => {
            let question = new Question();
            let computedId = id + ((virtualEntity.id - 1) * 3);
            question.id = computedId;
            question.question = `Test Question ${computedId}`;
            question.correctAnswer = `Test Answer ${computedId}`;
            question.options = [`Test Option ${computedId}`, `Test Option ${computedId + 1}`, `Test Option ${computedId + 2}`, `Test Option ${computedId + 3}`];
            question.quiz = virtualEntity.quiz!;
            question.type = QuestionType.TrueFalse;
            return question;
        })
    };
    virtualEntity.lessons = lessons.filter(lesson => {
        if (lesson.id % 3 === virtualEntity.id) {
            lesson.virtualEntities.push(virtualEntity);
            return true;
        }
        return false;
    });
    return virtualEntity;
});

eduGoOrg.virtualEntities = virtualEntities;