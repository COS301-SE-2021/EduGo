import multer from 'multer';
import azureStorage from 'azure-storage';
import { Readable } from 'stream';
import { InternalServerError } from 'routing-controllers';
import azurestorage from 'azure-storage';
import { Inject, Service } from 'typedi';

const inMemoryStorage = multer.memoryStorage();
export const upload = multer({ storage: inMemoryStorage })

@Service()
export class FileManagement {
    constructor(@Inject() private blobService: azurestorage.BlobService) {}

    private getBlobName(originalName: string) {
        const identifier = Math.random().toString().replace(/0\./, ''); // remove "0." from start of string
        return `${identifier}-${originalName}`;
    };

    public async UploadImageToAzure(file: Express.Multer.File): Promise<string> {
        return new Promise<string>((resolve, reject) => {
            let name = this.getBlobName(file.originalname);
            let length = file.buffer.length || 0;
            let stream = new Readable();
            stream.push(file.buffer);
            stream.push(null);
        
            this.blobService.createBlockBlobFromStream('edugo', `images/${name}`, stream, length, (err, result, response) => {
                if (err) {
                    console.log(err);
                    reject(err);
                    throw new InternalServerError('There was an error uploading the file');
                }
        
                resolve(this.blobService.getUrl('edugo', `images/${name}`));
            });
        });
    }

    public async UploadModelToAzure(file: Express.Multer.File): Promise<string> {
        return new Promise<string>((resolve, reject) => {
            let name = this.getBlobName(file.originalname);
            let stream = new Readable();
            stream.push(file.buffer);
            stream.push(null);
            let length = file.buffer.length || 0;
    
            this.blobService.createBlockBlobFromStream('edugo', `models/${name}`, stream, length, (err, result, response) => {
                if (err) {
                    console.log(err);
                    reject(err);
                    throw new InternalServerError('There was an error uploading the file');
                }
    
                resolve(this.blobService.getUrl('edugo', `models/${name}`))
            });
        });
    }
}

// const blobService = azureStorage.createBlobService();

// const getBlobName = (originalName: string) => {
//     const identifier = Math.random().toString().replace(/0\./, ''); // remove "0." from start of string
//     return `${identifier}-${originalName}`;
// };

// export const UploadImageToAzure = async (file: Express.Multer.File): Promise<string> => {
//     return new Promise<string>((resolve, reject) => {
//         let name = getBlobName(file.originalname);
//         let length = file.buffer.length || 0;
//         let stream = new Readable();
//         stream.push(file.buffer);
//         stream.push(null);
    
//         blobService.createBlockBlobFromStream('edugo', `images/${name}`, stream, length, (err, result, response) => {
//             if (err) {
//                 console.log(err);
//                 reject(err);
//                 throw new InternalServerError('There was an error uploading the file');
//             }
    
//             resolve(blobService.getUrl('edugo', `images/${name}`))
//         })
//     })
    
// }

// export const UploadModelToAzure = async (file: Express.Multer.File): Promise<string> => {
//     return new Promise<string>((resolve, reject) => {
//         let name = getBlobName(file.originalname);
//         let stream = new Readable();
//         stream.push(file.buffer);
//         stream.push(null);
//         let length = file.buffer.length || 0;

//         blobService.createBlockBlobFromStream('edugo', `models/${name}`, stream, length, (err, result, response) => {
//             if (err) {
//                 console.log(err);
//                 reject(err);
//                 throw new InternalServerError('There was an error uploading the file');
//             }

//             resolve(blobService.getUrl('edugo', `models/${name}`))
//         });
//     });
// }