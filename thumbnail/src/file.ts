import http from 'http';
import https from 'https';
import fs from 'fs';
import path from 'path';
import azureStorage from 'azure-storage';
import dotenv from 'dotenv';
import { InternalServerError } from './errors/Error';

dotenv.config();

const blobService = azureStorage.createBlobService();

const getKey = (key: string) => key.substring(key.lastIndexOf('/') + 1);


export const upload = (key: string) => {
    return new Promise<string>(function(resolve, reject) {
        let file: Buffer | undefined;
        try {
            file = fs.readFileSync(path.join(__dirname, 'output', key));
        }
        catch (err) {
            throw err;
        }

        if (!file) {
            throw new Error('File not found');
        }

        blobService.createBlockBlobFromLocalFile('edugo', `thumbnails/${key}`, path.join(__dirname, 'output', key), (err, result, response) => {
            if (err) {
                reject(err);
            }
            let url = blobService.getUrl('edugo', `thumbnails/${key}`);
            resolve(url);
        })
    });
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
    });
}

export const cleanUp = (inputKey: string, outputKey: string) => {
    try {
        fs.unlinkSync(path.join(__dirname, 'input', inputKey));
        fs.unlinkSync(path.join(__dirname, 'output', outputKey));
    }
    catch (err) {
        console.log(err);
        throw new InternalServerError('There was an error deleting the files');
    }
}

function getRequest(url: string) {
    return new Promise(function(resolve, reject) {
        https.get(url, function(response) {
            if (response.statusCode === 200) {
                resolve(response);
            } else {
                reject(response);
            }
        });
    });
}