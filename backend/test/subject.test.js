//import request from 'supertest'
//import app from './app.js'

const request = require('supertest')
const { app } = require('../dist/index')

describe("POST /lesson/createLesson", () => {

  describe("Subject is created ", () => {

   

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