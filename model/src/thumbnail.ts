import { spawnSync } from "child_process";
import fs from 'fs';
import { InternalServerError, NotFoundError } from './errors/Error'

/**
 * @description Generate a thumbnail for the already downloaded glb file using screenshot-glb and save it in the images directory
 * @param {string} input - The path to the glb file
 * @param {string} output - The path to the output image
 */
export const generateThumbnail = (input: string, output: string) => {
    //Check to see if file exists
    if (!fs.existsSync(`${__dirname}/input/${input}`)) {
        throw new NotFoundError("File does not exist");
    }
    //TODO: check if output folder exists
    //Try using the fs.mkdir function to create the output folder if it doesn't exist
    //If the folder already exists, do nothing
    let run = spawnSync('screenshot-glb', [`-i ${__dirname}/input/${input}`, `${__dirname}/output/${output}`]);
    if (run.status !== 0) {
        throw new InternalServerError("Error generating thumbnail");
    }
}