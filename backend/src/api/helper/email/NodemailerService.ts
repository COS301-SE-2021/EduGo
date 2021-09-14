import { EmailService } from "./EmailService";
import { AddedToSubjectEmail } from "./models/AddedToSubjectEmail";
import { VerificationEmail } from "./models/VerificationEmail";
import nodemailer from "nodemailer";
import fs from "fs";
import Handlebars from "handlebars";
import {
	AddedToSubjectTemplateObject,
	VerificationCodeTemplateObject,
} from "./models/TemplateObjects";
import SMTPTransport from "nodemailer/lib/smtp-transport";
import { InternalServerError } from "routing-controllers";

type EmailType = "verification" | "reminder" | "added";

export class NodemailerService implements EmailService {
	private transporter: nodemailer.Transporter<SMTPTransport.SentMessageInfo>;
	verificationCodeTemplate: HandlebarsTemplateDelegate<VerificationCodeTemplateObject>;
	verificationReminderTemplate: HandlebarsTemplateDelegate<VerificationCodeTemplateObject>;
	addedToSubjectTemplate: HandlebarsTemplateDelegate<AddedToSubjectTemplateObject>;

	constructor() {
		let rawVerificationCodeTemplate = fs.readFileSync(
			`${__dirname}/templates/VerificationCode.hbs`,
			"utf-8"
		);
		let rawVerificationReminderTemplate = fs.readFileSync(
			`${__dirname}/templates/VerificationReminder.hbs`,
			"utf-8"
		);
		let rawAddedToSubjectTemplate = fs.readFileSync(
			`${__dirname}/templates/AddedToSubject.hbs`,
			"utf-8"
		);
		this.verificationCodeTemplate = Handlebars.compile(
			rawVerificationCodeTemplate
		);
		this.verificationReminderTemplate = Handlebars.compile(
			rawVerificationReminderTemplate
		);
		this.addedToSubjectTemplate = Handlebars.compile(
			rawAddedToSubjectTemplate
		);
	
		this.transporter = nodemailer.createTransport({
			host: process.env.SMTP_HOST,
			port: Number(process.env.SMTP_PORT),
			secure: false,
			auth: {
				user: process.env.SMTP_USERNAME,
				pass: process.env.SMTP_PASSWORD,
			},
		});
	}
	sendOneEmail(to: string, name: string, code: string): void {
		let html = this.verificationCodeTemplate({
			code: code,
			link: `http://localhost:8082/?user=sthenyandeni&code=ABCD`,
		});

		let mailOptions = {
			from: process.env.EMAIL,
			to: to,
			subject: "Verification Code",
			html: html,
		};

		this.transporter.sendMail(mailOptions, (err) => {
			if (err) throw new InternalServerError("Email not sent");

			console.log("email sent");
		});
	}
	async SendBulkVerificationEmails(
		emails: VerificationEmail[]
	): Promise<boolean> {
		return this.SendBulkTemplateEmail("verification", emails);
	}

	async SendBulkVerificationReminderEmails(
		emails: VerificationEmail[]
	): Promise<boolean> {
		return this.SendBulkTemplateEmail("reminder", emails);
	}

	async SendBulkAddedToSubjectEmails(
		emails: AddedToSubjectEmail[]
	): Promise<boolean> {
		return this.SendBulkTemplateEmail("added", emails);
	}

	private async SendBulkTemplateEmail(
		type: EmailType,
		content: VerificationEmail[] | AddedToSubjectEmail[]
	): Promise<boolean> {
		if (content.length === 0) return true;

		let recipientEmails: string = content
			.map((value) => value.email)
			.join(", ");

		let recipientJSON: any = [];

		if (type === "verification" && this.isVerificationEmail(content)) {
			for (let i = 0; i < content.length; i++) {
				recipientJSON.push(
					this.sendMail({
						from: process.env.EMAIL,
						to: content[i].email,
						subject: "Verification Code",
						html: this.verificationCodeTemplate({
							code: content[i].code,
							link: "",
						}),
					}).catch(() => false)
				);
			}
		} else if (type === "reminder" && this.isVerificationEmail(content)) {
			for (let i = 0; i < content.length; i++) {
				recipientJSON.push(
					this.sendMail({
						from: process.env.EMAIL,
						to: content[i].email,
						subject: "Just a little reminder",
						html: this.verificationReminderTemplate({
							code: content[i].code,
							link: "",
						}),
					}).catch(() => false)
				);
			}
		} else if (type === "added" && this.isAddedToSubjectEmail(content)) {
			for (let i = 0; i < content.length; i++) {
				recipientJSON.push(
					this.sendMail({
						from: process.env.EMAIL,
						to: content[i].email,
						subject: "Another subject",
						html: this.addedToSubjectTemplate({
							name: content[i].name,
							subject: content[i].subject,
						}),
					}).catch(() => false)
				);
				recipientJSON[content[i].email] = {
					html: this.addedToSubjectTemplate({
						name: content[i].name,
						subject: content[i].subject,
					}),
				};
			}
		} else return false;
		return true;

		// return Promise.all(recipientJSON)
		// 	.then((result) => {
		// 		console.log("all emails sent");
		// 		return true;
		// 	})
		// 	.catch((error) => {
		// 		throw new InternalServerError("emails not sent");
		// 	});
	}
	private sendMail(mail: any) {
		return new Promise((resolve, reject) => {
			this.transporter.sendMail(mail, (error, response) => {
				if (error) {
					console.log(error);
					reject(error);
				} else {
					console.log("Message sent: " + JSON.stringify(response));
					resolve(response);
				}

				this.transporter.close();
			});
		});
	}
	private isVerificationEmail(object: any[]): object is VerificationEmail[] {
		return object.every((value) => "code" in value);
	}

	private isAddedToSubjectEmail(
		object: any[]
	): object is AddedToSubjectEmail[] {
		return object.every((value) => "name" in value && "subject" in value);
	}
}
