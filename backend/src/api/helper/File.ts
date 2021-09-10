import multer from 'multer';
import azureStorage from 'azure-storage';
import getStream from 'get-stream';
import express from 'express';
import { Readable, Stream } from 'stream';

const inMemoryStorage = multer.memoryStorage();
export const uploadStrategy = multer({ storage: inMemoryStorage }).single('file');

const blobService = azureStorage.createBlobService();

const getBlobName = (originalName: string) => {
    const identifier = Math.random().toString().replace(/0\./, ''); // remove "0." from start of string
    return `${identifier}-${originalName}`;
};

export const UploadToAzure = async (req: express.Request) => {
    let name = getBlobName(req.file.originalname);
}