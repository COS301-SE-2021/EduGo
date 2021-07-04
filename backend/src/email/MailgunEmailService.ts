import { EmailService } from "./EmailService";
import mailgun from 'mailgun-js';
import Handlebars from 'handlebars';
import fs from 'fs';
import { VerificationCodeInterface } from './models/VerificationCodeTemplateObject';
import { VerificationEmail } from "./models/VerificationEmail";

const FROM = `EduGo <test@${process.env.MAILGUN_DOMAIN}>`;

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
            code: code,
            link: `http://localhost:8082/?user=sthenyandeni&code=ABCD`
        });

        
        let data: mailgun.messages.SendData = {
            to: to,
            subject: 'Verification Code',
            from: FROM,
            html: html
        }
        console.log(data);
        this.mg.messages().send(data).then(result => {
            console.log(result);
        })
    }

    async SendBulkVerificationEmails(emails: VerificationEmail[]): Promise<boolean> {
        let recipientEmails: string = emails.map(value => value.email).join(', ');

        let recipientJSON: any = {};
        for (let i = 0; i < emails.length; i++) {
            recipientJSON[emails[i].email] = {html: this.verificationCodeTemplate({code: emails[i].code, link: ''})}
        }

        let data: mailgun.messages.BatchData = {
            to: recipientEmails,
            from: FROM,
            subject: 'Verification Code',
            html: '%recipient.html%',
            'recipient-variables':  JSON.stringify(recipientJSON)
        }

        return this.mg.messages().send(data).then(result => {
            console.log('Sent email result')
            console.log(result);
            return true;
        })
        .catch(err => {
            return false;
        })
    }

}