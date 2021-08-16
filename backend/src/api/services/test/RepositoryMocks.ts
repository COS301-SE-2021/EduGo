import { Subject } from "../../database/Subject";
import { Repository } from "typeorm";

let subject: Subject = new Subject();
subject.lessons = [0, 1, 2, 3].map((value) => ({id: value, title: `Lesson ${value}`, description: 'Something', startTime: new Date(), endTime: new Date(), subject: subject, virtualEntities: []}));

export const repositoryMock: (returnEntity:any) => MockType<Repository<any>> = jest.fn(() => ({
    save: jest.fn(entity => new Promise((res, rej) => res(entity))),
    findOne: jest.fn(() => new Promise((res, rej) => res(subject))),
}));

// export 

export type MockType<T> = {
    [P in keyof T]?: jest.Mock<{}>;
};

 