//import request from 'supertest'
//import app from './app.js'

const request = require('supertest')
const { app } = require('../dist/index')

describe("POST /virtualEntity/createVirtualEntity", () => {

  describe("Virtual Entity is created ", () => {
    test("should respond with a 200 status code", async () => {
        const response = await request(app).post("/subject/createSubject").send({
          
          description: "Some Subject description",
          title:"Edugo Subject",
           
        })
        expect(response.statusCode).toBe(200)
      })
  

  })

  describe("when the one of the parameters are missing", () => {
    test("should respond with a 400 status code", async () => {
      const response = await request(app).post("/subject/createSubject").send({
        
        title:"Edugo Subject",
         
      })
      expect(response.statusCode).toBe(400)
    })

  })

})