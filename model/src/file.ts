import aws from 'aws-sdk';
import fs from 'fs';
import path from 'path';

var s3 = new aws.S3({
    accessKeyId: process.env.AWS_ACCESS_KEY,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    region: 'af-south-1',
});

const getKey = (key: string) => key.substring(key.lastIndexOf('/') + 1);

export const upload = (path: string) => {

}

export const download = async (url: string): Promise<boolean> => {
    return new Promise<boolean>(async (resolve, reject) => {
        let key = getKey(url);
        let options: aws.S3.GetObjectRequest = {
            Bucket: 'edugo-files',
            Key: `test_models/${key}`,
        }
        let readStream = await s3.getObject(options).createReadStream();
        let writeStream = fs.createWriteStream(path.join(__dirname, 'models', key));
        readStream.pipe(writeStream);
        readStream.on('end', () => {
            resolve(true);
        });
        readStream.on('error', (err) => {
            reject(err);
        });

    });
}