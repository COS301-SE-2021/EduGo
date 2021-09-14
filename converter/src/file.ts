import fs from 'fs';
import path from 'path';
import http from 'http';
import https from 'https';
import dotenv from 'dotenv';
import azureStorage from 'azure-storage';
import { InternalServerError } from './error';

dotenv.config();

const blobService = azureStorage.createBlobService();

const getKey = (key: string) => key.substring(key.lastIndexOf('/') + 1);

const getRequest = (url: string) => {
    return new Promise((resolve, reject) => {
        https.get(url, (response) => {
            if (response.statusCode === 200)
                resolve(response);
            else 
                reject(response);
        });
    });
}

export const upload = async (key: string) => {
    const dir = path.join(__dirname, 'output', key);
    let list: string[] = [];
    try {
        list = fs.readdirSync(dir);
    }
    catch (err) {
        console.log(err);
        throw new InternalServerError(`There was an error opening the output/${key} directory`);
    }
    let urls = await Promise.all(list.map((fileName) => {
        return new Promise<string>((resolve, reject) => {
            let file: Buffer | undefined;
            try {
                file = fs.readFileSync(path.join(dir, fileName));
            }
            catch (err) {
                console.log(err);
                throw new InternalServerError(`There was an error opening the output/${key}/${fileName} file`);
            }
            if (!file) throw new InternalServerError('File not found');

            blobService.createBlockBlobFromLocalFile('edugo', `models/${key}/${fileName}`, path.join(dir, fileName), (err, result, response) => {
                if (err) reject(err);
                let url = blobService.getUrl('edugo', `models/${key}/${fileName}`);
                resolve(url);
            });
            // resolve(`https://edugo.blob.core.windows.net/models/${key}/${fileName}`);
        });
    }));
    return urls;
}

export const download = (url: string) => {
    return new Promise<string>(async (resolve, reject) => {
        const response = await getRequest(url);
        const fileName = getKey(url);
        const file = fs.createWriteStream(path.join(__dirname, 'input', fileName));

        (response as http.IncomingMessage).pipe(file);
        file.on('close', () => {
            resolve(fileName);
        });
        file.on('error', (err) => {
            reject(err);
        })
    })
}

export const clean = (inputKey: string, outputKey: string) => {
    try {
        fs.unlinkSync(path.join(__dirname, 'input', inputKey));
        fs.rmSync(path.join(__dirname, 'output', outputKey), {recursive: true, force: true});
    }
    catch (err) {
        console.log(err);
        throw new InternalServerError(`There was an error cleaning the ${inputKey} & ${outputKey} directories`);
    }
}

