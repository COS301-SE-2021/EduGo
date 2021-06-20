import { createConnection } from "typeorm";

import {app} from '../index';


describe('Testing if tests work', () => {
    it('Should pass', () => {
        let i = 2 + 10;
        expect(i).toBe(12);
    })
})