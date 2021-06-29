import { EmailService } from "./EmailService";
import mailgun from 'mailgun-js';
import Handlebars from 'handlebars';
import fs from 'fs';
import { VerificationCodeInterface } from './VerificationCodeInterface';

export class MailgunEmailService implements EmailService {
    mg: mailgun.Mailgun;
    verificationCodeTemplate: HandlebarsTemplateDelegate<VerificationCodeInterface>;
    constructor() {
        this.mg = mailgun({
            apiKey: process.env.MAILGUN_API_KEY!,
            domain: process.env.MAILGUN_DOMAIN!
        })
        let rawVerificationCodeTemplate = fs.readFileSync(__dirname + '/templates/VerificationCode.hbs', 'utf-8');
        this.verificationCodeTemplate = Handlebars.compile(rawVerificationCodeTemplate);
    }

    sendOneEmail(to: string, name: string, code: string): void {
        let html = this.verificationCodeTemplate({
            name: name,
            code: code,
            link: `http://localhost:8082/?user=sthenyandeni&code=ABCD`
        });
        let data: mailgun.messages.SendData = {
            to: to,
            subject: 'Test',
            from: `EduGo <test@${process.env.MAILGUN_DOMAIN}>`,
            html: html
        }
        console.log(data);
        this.mg.messages().send(data).then(result => {
            console.log(result);
        })
    }

}