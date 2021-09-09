import aws from 'aws-sdk';
import fs from 'fs';
import path from 'path';
import { InternalServerError } from './errors/Error';

var s3 = new aws.S3({
    accessKeyId: process.env.AWS_ACCESS_KEY,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    region: 'af-south-1',
});

const getKey = (key: string) => key.substring(key.lastIndexOf('/') + 1);

export const upload = async (key: string) => {
    let file: Buffer | undefined;
    try {
        const filePath = path.join(__dirname, 'output', key);
        file = fs.readFileSync(filePath);
    }
    catch (err) {
        console.log('uploading')
        console.log(err);
        throw err;
    }
    let params = {
        Bucket: 'edugo-files',
        Key: key,
        Body: file,
    };

    return s3.putObject(params).promise()
}

export const download = async (url: string): Promise<string> => {
    return new Promise<string>(async (resolve, reject) => {
        let key = getKey(url);
        let options: aws.S3.GetObjectRequest = {
            Bucket: 'edugo-files',
            Key: `test_models/${key}`,
        }
        console.log(key);
        let readStream = await s3.getObject(options).createReadStream();
        let writeStream = fs.createWriteStream(path.join(__dirname, 'input', key));
        readStream.pipe(writeStream);
        readStream.on('end', () => {
            resolve(key);
        });
        readStream.on('error', (err) => {
            reject(err);
        });
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