import fs from 'fs';
import path from 'path';
import { execSync } from "child_process";
import { InternalServerError, NotFoundError } from './error';


export const convert = (input: string) => { //Filename
    if (!fs.existsSync(`${__dirname}/input/${input}`)) 
        throw new NotFoundError(`File: ${input} does not exist`);

    let key = removeExtension(input); 
    let output = generateOutputName(input);

    if (fs.existsSync(path.join(__dirname, 'output', key)))
        fs.unlinkSync(path.join(__dirname, 'output', key));
    fs.mkdirSync(path.join(__dirname, 'output', key));

    try {
        let command = `gltf-pipeline -i ${path.join(__dirname, 'input', input)} -o ${path.join(__dirname, 'output', key, output)} -s`;
        console.log(command);
        const run = execSync(command);
    }
    catch (err) {
        console.log(err);
        throw new InternalServerError(`There was an error converting the .glb file ${input}`);
    }
    return key;
}

const generateOutputName = (input: string): string => {
    return `${input.replace(".glb", ".gltf")}`;
}

const removeExtension = (input: string): string => {
    return input.replace(".glb", "");
}