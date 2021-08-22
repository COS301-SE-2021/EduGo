import {platform} from 'os';
import {spawnSync} from 'child_process';
import express from 'express';
import cors from 'cors';
import { HandleResponse } from './errors/Error';
import dotenv from 'dotenv';
import { download } from './file';

dotenv.config();

//Check to see if necessary environment variables are set
if (!("AWS_ACCESS_KEY" in process.env)) throw new Error("AWS Access Key missing");
if (!("AWS_SECRET_ACCESS_KEY" in process.env)) throw new Error("AWS Secret Access Key missing");

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

app.post('/', (req, res) => {
    try {
        res.send('ok');
    }
    catch (err) {
        HandleResponse(res, err);
    }
});

app.post('/download', async (req, res) => {
    let url: string = req.body.url ?? '';
    if (url === '') {
        res.status(400).send('No URL provided');
        return;
    }
    let status: boolean = false;
    try {
        status = await download(url);
    }
    catch (err) {
        res.status(500).send(err.message);
    }
    res.status(400).send(status ? 'ok' : 'error');
})

app.listen(PORT, () => console.log(`Listening on port ${PORT}`))