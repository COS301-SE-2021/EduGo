import supertest from "supertest";
const { app } = require('../dist/index')

//LESSON

describe("POST /lesson/createLesson", () => {
    // beforeAll(async() => {
    //     app = import('../dist/index')
    // })
  describe("Lesson is created ", () => {

    test("should respond with a 200 status code", async () => {


      const response = await supertest(app).post("")
      .send({
        subjectId:1,
        description: "Some Lesson description",
        title:"Edugo Lesson",
        date: "20 june" });
        expect("").toBe(200);
  })

  
  describe("when the one of the parameters are missing", () => {
 
  })

})

})