import {platform} from 'os';
import {spawnSync} from 'child_process';
import express from 'express';
import cors from 'cors';
import { HandleResponse } from './errors/Error';
import dotenv from 'dotenv';
import { cleanUp, download, upload } from './file';
import { generateThumbnail } from './thumbnail';
import fs from "fs";
import path from 'path';

dotenv.config();

//Check to see if necessary environment variables are set
if (!("AZURE_STORAGE_CONNECTION_STRING" in process.env)) throw new Error("Azure Storage Connection String missing");

//Get the current platform
let p = platform()
let command = p === 'darwin' ? 'which' : (p === 'linux' ? 'whereis' : (p === 'win32' ? 'where' : undefined));

//Test to see if the screenshot-glb program exists on this machine
if (command) {
    let test = spawnSync(command, ['screenshot-glb'], {encoding: 'utf8'});
    if (
        test.error !== undefined ||
        test.status !== 0 ||
        test.stderr !== '' ||
        test.stdout == '' ||
        test.stdout.indexOf('screenshot-glb') === -1
    ) throw new Error('There was an error finding the screenshot-glb program')
}
else throw new Error('Incompatible platform detected');

//Check if input folder exists, otherwise create it
if (!fs.existsSync(path.join(__dirname, 'input')))
    fs.mkdirSync(path.join(__dirname, 'input'));

//Check if output folder exists, otherwise create it
if (!fs.existsSync(path.join(__dirname, 'output')))
    fs.mkdirSync(path.join(__dirname, 'output'));

//Initialise the express app
const app = express();
app.use(cors(
    {
        origin: '*',
		methods: "GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS",
    }
));
app.use(express.json())
app.use(express.urlencoded({extended: true}));
const PORT = process.env.PORT || 8085;

app.post('/', async (req, res) => {
    if (!('url' in req.body)) {
        res.status(400).send('No URL provided')
        return;
    }
    let url = req.body.url;
    try {
        let inputKey = await download(url);
        let outputKey = generateThumbnail(inputKey);
        try {
            let uploadData = await upload(outputKey);
            res.status(200).json({download: url, uploaded: uploadData});
        }
        catch (err) {
            console.log('finishing off')
            throw err;
        }
        cleanUp(inputKey, outputKey);
    }
    catch (err) {
        HandleResponse(res, err);
    }
});

app.listen(PORT, () => console.log(`Listening on port ${PORT}`))