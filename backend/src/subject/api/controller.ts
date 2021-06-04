import express from 'express';

const router = express.Router();

router.use((req, res, next) => {
    next()
})

router.post('/createSubject', async (req, res) => {
    //Create subject
})

export {router}