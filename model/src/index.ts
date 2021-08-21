import {platform} from 'os';
import {spawnSync} from 'child_process';

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

