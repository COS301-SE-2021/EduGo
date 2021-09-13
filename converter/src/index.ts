import { platform } from 'os';
import { spawnSync } from 'child_process';
import { HandleResponse } from './error';
import { convert } from './converter';
import { clean, download, upload } from './file';
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import path from 'path';
import fs from 'fs';

dotenv.config();

//Check to see if necessary environment variables are set
if (!("AZURE_STORAGE_CONNECTION_STRING" in process.env)) throw new Error("Azure Storage Connection String missing");

//Get the current platform
let p = platform();
let command = p === 'darwin' ? 'which' : (p === 'linux' ? 'whereis' : (p === 'win32' ? 'where' : undefined));

//Test to see if the gltf-pipeline program has been installed
if (command) {
    let test = spawnSync(command, ['gltf-pipeline'], {encoding: 'utf8'});
    if (
        test.error !== undefined ||
        test.status !== 0 ||
        test.stderr !== '' ||
        test.stdout == '' ||
        test.stdout.indexOf('gltf-pipeline') === -1
    ) throw new Error('There was an error finding the gltf-pipeline program');
}
else throw new Error('Incompatible platform detected');

//Check if input folder exists, otherwise create it
if (!fs.existsSync(path.join(__dirname, 'input')))
    fs.mkdirSync(path.join(__dirname, 'input'));

//Check if output folder exists, otherwise create it
if (!fs.existsSync(path.join(__dirname, 'output')))
    fs.mkdirSync(path.join(__dirname, 'output'));

const PORT = process.env.PORT || 8084;

const app = express();
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(cors(
    {
        origin: '*',
        methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',
    }
));

app.post('/', async (req, res) => {
    if (!('url' in req.body)) {
        res.status(400).send('No URL provided');
        return;
    }
    let url = req.body.url;

    try {
        let inputKey = await download(url);
        let outputKey = await convert(inputKey);
        try {
            let uploadData = await upload(outputKey);
            res.status(200).json(uploadData);
        }
        catch (err) {
            res.status(500).send('Failed to upload');
        }
        clean(inputKey, outputKey);
    }
    catch (err) {
        HandleResponse(res, err);
    }
})

app.listen(PORT, () => console.log(`Listening on port ${PORT}`));