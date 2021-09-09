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

//Password: password
export const adminUser = new User();
adminUser.id = 1;
adminUser.username = "admin";
adminUser.email = "admin@edugo.com";
adminUser.firstName = "Admin";
adminUser.lastName = "EduGo";
adminUser.salt = '823b5290ad76a63592760753b0c683bb2769f4d27f391b355ae45176d9a5725c';
adminUser.hash = '9b0682468581255f592253395146fae1cfcc22bb4a41ba71444329e6d572996bd4596d94f6ff4a51dbabf0d2c09ce496032e6b610df6a402d3bb70fcae49b2aa';
adminUser.educator = {
    admin: true,
    id: 1,
    subjects: [],
    user: adminUser
}
adminUser.organisation = eduGoOrg;
eduGoOrg.users.push(adminUser);

//Password: password
export const educatorUser = new User();
educatorUser.id = 2;
educatorUser.username = "educator";
educatorUser.email = "educator@edugo.com";
educatorUser.firstName = "Educator";
educatorUser.lastName = "EduGo";
educatorUser.salt = '823b5290ad76a63592760753b0c683bb2769f4d27f391b355ae45176d9a5725c';
educatorUser.hash = '9b0682468581255f592253395146fae1cfcc22bb4a41ba71444329e6d572996bd4596d94f6ff4a51dbabf0d2c09ce496032e6b610df6a402d3bb70fcae49b2aa';
educatorUser.educator = {
    admin: false,
    id: 2,
    subjects: [],
    user: educatorUser
}
educatorUser.organisation = eduGoOrg;
eduGoOrg.users.push(educatorUser);

//Password: password
export const studentUser = new User();
studentUser.id = 3;
studentUser.username = "student";
studentUser.email = "student@edugo.com";
studentUser.firstName = "Student";
studentUser.lastName = "EduGo";
studentUser.salt = '823b5290ad76a63592760753b0c683bb2769f4d27f391b355ae45176d9a5725c';
studentUser.hash = '9b0682468581255f592253395146fae1cfcc22bb4a41ba71444329e6d572996bd4596d94f6ff4a51dbabf0d2c09ce496032e6b610df6a402d3bb70fcae49b2aa';
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