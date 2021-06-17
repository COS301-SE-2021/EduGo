// const request = require('supertest')
// const { app } = require('../dist/index')

// //LESSON

// describe("POST /lesson/createLesson", () => {
//     // beforeAll(async() => {
//     //     app = import('../dist/index')
//     // })
//   describe("Lesson is created ", () => {

//     test("should respond with a 200 status code", async () => {
//       const response = await request(app).post("/lesson/createLesson").send({
        
//         subjectId:1,
//         description: "Some Lesson description",
//         title:"Edugo Lesson",
//         date: "20 june"
         
//       })
//       expect(response.statusCode).toBe(200)
//     })
//     test("should specify json in the content type header", async () => {
//       const response = await request(app).post("/lesson/createLesson").send({
          
//         subjectId:1,
//         description: "Some Lesson description",
//         title:"Edugo Lesson",
//         date: "20 june"
         
//       })
//       expect(response.headers['content-type']).toEqual(expect.stringContaining("json"))
//     })
//     // test("response has userId", async () => {
//     //   const response = await request(app).post("/users").send({
//     //     username: "username",
//     //     password: "password"
//     //   })
//     //   expect(response.body.message).toEqual("Lesson created successfully")
//     // })
//   })

//   describe("when the one of the parameters are missing", () => {
//     test("should respond with a 400 status code", async () => {
//       const response = await request(app).post("/lesson/createLesson").send({
        
//         subjectId:1,
//         description: "Some Lesson description",
//         date: "20 june"
         
//       })
//       expect(response.statusCode).toBe(400)
//     })
//   })

// })

// //LESSON

// //SUBJECT

// describe("POST /subject/createSubject", () => {

//     describe("Subject is created ", () => {
  
//       test("should respond with a 200 status code", async () => {
//           const response = await request(app).post("/subject/createSubject").send({
            
//             description: "Some Subject description",
//             title:"Edugo Subject",
             
//           })
//           expect(response.statusCode).toBe(200)
//         })
//         test("should specify json in the content type header", async () => {
//           const response = await request(app).post("/subject/createSubject").send({
              
//             description: "Some Subject description",
//             title:"Edugo Subject",
             
//           })
//           expect(response.headers['content-type']).toEqual(expect.stringContaining("json"))
//         })
  
//     })
  
//     describe("when the one of the parameters are missing", () => {
//       test("should respond with a 400 status code", async () => {
//         const response = await request(app).post("/subject/createSubject").send({
          
//           title:"Edugo Subject",
           
//         })
//         expect(response.statusCode).toBe(400)
//       })
//     })
  
//   })

// //SUBJECT

// //VIRTUAL ENTITY

// describe("POST /virtualEntity/createVirtualEntity", () => {

//     describe("Virtual Entity is created ", () => {
//       test("should respond with a 200 status code", async () => {
//           const response = await request(app).post("/virtualEntity/createVirtualEntity").send({
//             description: "Some Virtual Entity description",
//             title:"Edugo Virtual Entity",
            
             
//           })
//           expect(response.statusCode).toBe(200)
//         })
//         test("should specify json in the content type header", async () => {
//           const response = await request(app).post("/virtualEntity/createVirtualEntity").send({
              
//             description: "Some Virtual Entity description",
//             title:"Edugo Virtual Entity",
             
//           })
//           expect(response.headers['content-type']).toEqual(expect.stringContaining("json"))
//         })
  
//     })
  
//     describe("when the one of the parameters are missing", () => {
//       test("should respond with a 400 status code", async () => {
//         const response = await request(app).post("/virtualEntity/createVirtualEntity").send({
          
//           title:"Edugo Virtual Entity",
           
//         })
//         expect(response.statusCode).toBe(400)
//       })
  
//     })
  
//   })

