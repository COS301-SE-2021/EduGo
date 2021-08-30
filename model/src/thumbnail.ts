import { spawnSync, SpawnSyncReturns, execSync } from "child_process";
import fs from 'fs';
import path from "path";
import { InternalServerError, NotFoundError } from './errors/Error'

/**
 * @description Generate a thumbnail for the already downloaded glb file using screenshot-glb and save it in the images directory
 * @param {string} input - The path to the glb file
 * @param {string} output - The path to the output image
 */
export const generateThumbnail = (input: string) => {
    //Check to see if file exists
    if (!fs.existsSync(`${__dirname}/input/${input}`)) {
        throw new NotFoundError("File does not exist");
    }
    let output = generateOutputName(input);
    try {
        const run = execSync(`screenshot-glb -i ${path.join(__dirname, 'input', input)} -o ${path.join(__dirname, 'output', output)}`, {encoding: 'utf8'});
    }
    catch (err) {
        console.log(err);
        throw new InternalServerError(err)
    }
    return output;
}

const generateOutputName = (input: string): string => {
    return `${input.replace(".glb", ".png")}`;
}