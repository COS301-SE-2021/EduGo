import { EmailService } from "./EmailService";
import { AddedToSubjectEmail } from "./models/AddedToSubjectEmail";
import { VerificationEmail } from "./models/VerificationEmail";
import nodemailer from "nodemailer";
import fs from "fs";
import Handlebars from 'handlebars';
import { VerificationCodeTemplateObject } from "./models/TemplateObjects";
import SMTPTransport from "nodemailer/lib/smtp-transport";
import { InternalServerError } from "routing-controllers";
export class NodemailerService implements EmailService {
	private transporter: nodemailer.Transporter<SMTPTransport.SentMessageInfo>;
	verificationCodeTemplate: HandlebarsTemplateDelegate<VerificationCodeTemplateObject>;

	constructor() {
		let rawVerificationCodeTemplate = fs.readFileSync(
			`${__dirname}/templates/VerificationCode.hbs`,
			"utf-8"
		);
		this.verificationCodeTemplate = Handlebars.compile(
			rawVerificationCodeTemplate
		);

		this.transporter = nodemailer.createTransport({
			service: "gmail",
			auth: {
				user: process.env.GMAIL_EMAIL,
				pass: process.env.GMAIL_PASSWORD,
			},
		});
	}
	sendOneEmail(to: string, name: string, code: string): void {
		let html = this.verificationCodeTemplate({
			code: code,
			link: `http://localhost:8082/?user=sthenyandeni&code=ABCD`,
		});

		let mailOptions = {
			from: process.env.GMAIL_EMAIL,
			to: to,
			subject: "Verification Code",
			text: html,
		};

		this.transporter.sendMail(mailOptions, (err) => {
			if (err) throw new InternalServerError("Email not sent");

			console.log("email sent");
		});
	}
	async SendBulkVerificationEmails(
		emails: VerificationEmail[]
	): Promise<boolean> {
		for (let email in emails) {
		}
		console.log(`Sending bulk verifications emails...`);
		console.log(emails);

		return true;
	}
	async SendBulkVerificationReminderEmails(
		emails: VerificationEmail[]
	): Promise<boolean> {
		console.log(`Sending bulk verification reminder emails...`);
		console.log(emails);
		return true;
	}
	async SendBulkAddedToSubjectEmails(
		emails: AddedToSubjectEmail[]
	): Promise<boolean> {
		console.log(`Sending added to subject emails...`);
		console.log(emails);
		return true;
	}
}
