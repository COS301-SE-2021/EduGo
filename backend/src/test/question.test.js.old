//import request from 'supertest'
//import app from './app.js'

const request = require('supertest')
const { app } = require('../dist/index')

describe("POST /lesson/createQuestion", () => {
    // beforeAll(async() => {
    //     app = import('../dist/index')
    // })
  describe("Question is created ", () => {

    test("should respond with a 200 status code", async () => {
      const response = await request(app).post("/question/createQuestion").send({
        
       question:"Reandom question", 
       correctAnser:"Random correct answer"
         
      })
      expect(response.statusCode).toBe(200)
    })
    test("should specify json in the content type header", async () => {
      const response = await request(app).post("/question/createQuestion").send({
          
        question:"Reandom question", 
        correctAnser:"Random correct answer"
         
      })
      expect(response.headers['content-type']).toEqual(expect.stringContaining("json"))
    })
    // test("response has userId", async () => {
    //   const response = await request(app).post("/users").send({
    //     username: "username",
    //     password: "password"
    //   })
    //   expect(response.body.message).toEqual("Question created successfully")
    // })
  })

  describe("when the one of the parameters are missing", () => {
    test("should respond with a 400 status code", async () => {
      const response = await request(app).post("/question/createQuestion").send({
        
        correctAnser:"Random correct answer"
         
      })
      expect(response.statusCode).toBe(400)
    })
  })

})