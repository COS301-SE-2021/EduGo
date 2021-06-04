//import request from 'supertest'
//import app from './app.js'

const request = require('supertest')
const { app } = require('../dist/index')

describe("POST /virtualEntity/createVirtualEntity", () => {

  describe("Virtual Entity is created ", () => {
    test("should respond with a 200 status code", async () => {
        const response = await request(app).post("/virtualEntity/createVirtualEntity").send({
          description: "Some Virtual Entity description",
          title:"Edugo Virtual Entity",
          
           
        })
        expect(response.statusCode).toBe(200)
      })
      test("should specify json in the content type header", async () => {
        const response = await request(app).post("/virtualEntity/createVirtualEntity").send({
            
          description: "Some Virtual Entity description",
          title:"Edugo Virtual Entity",
           
        })
        expect(response.headers['content-type']).toEqual(expect.stringContaining("json"))
      })

  })

  describe("when the one of the parameters are missing", () => {
    test("should respond with a 400 status code", async () => {
      const response = await request(app).post("/virtualEntity/createVirtualEntity").send({
        
        title:"Edugo Virtual Entity",
         
      })
      expect(response.statusCode).toBe(400)
    })

  })

})