import { Organisation } from "../../../../api/database/Organisation";
import { Subject } from "../../../../api/database/Subject";
import { User } from "../../../../api/database/User";

export const users: User[] = [0, 1, 2, 3].map(value => {
    let user = new User();
    user.id = 1;
    user.username = `user${value + 1}`;
    user.email = `user${value + 1}@edugo.com`;
    user.firstName = `User`;
    user.lastName = `Surname`;
    return user;
});

export const subject: Subject = new Subject();
subject.lessons = [0, 1, 2, 3].map((value) => ({
    id: value, 
    grades: [], 
    title: `Lesson ${value}`, 
    description: 'Something', 
    subject: subject, 
    virtualEntities: []
}));

export const organisation: Organisation = new Organisation();
organisation.id = 1;
organisation.name = "EduGo University";
organisation.email = "edugo@edugo.com"
organisation.users = users;
organisation.virtualEntities = [];
organisation.phone = "0123456789";
organisation.subjects = [subject];

users.forEach(user => user.organisation = organisation);