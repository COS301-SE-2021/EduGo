//import request from 'supertest'
//import app from './app.js'

const request = require('supertest')
const { app } = require('../dist/index')

describe("POST /lesson/createLesson", () => {

  describe("Subject is created ", () => {

    test("should respond with a 200 status code", async () => {
        const response = await request(app).post("/subject/createSubject").send({
          
          description: "Some Subject description",
          title:"Edugo Subject",
           
        })
        expect(response.statusCode).toBe(200)
      })
      test("should specify json in the content type header", async () => {
        const response = await request(app).post("/lesson/createLesson").send({
            
          description: "Some Subject description",
          title:"Edugo Subject",
           
        })
        expect(response.headers['content-type']).toEqual(expect.stringContaining("json"))
      })

  })

  describe("when the one of the parameters are missing", () => {
    test("should respond with a 400 status code", async () => {
      const response = await request(app).post("/lesson/createLesson").send({
        
        title:"Edugo Subject",
         
      })
      expect(response.statusCode).toBe(400)
    })
  })

})