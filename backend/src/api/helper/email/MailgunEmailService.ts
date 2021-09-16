import { EmailService } from "./EmailService";
import mailgun from "mailgun-js";
import Handlebars from "handlebars";
import fs from "fs";
import {
	VerificationCodeTemplateObject,
	AddedToSubjectTemplateObject,
} from "./models/TemplateObjects";
import { VerificationEmail } from "./models/VerificationEmail";
import { AddedToSubjectEmail } from "./models/AddedToSubjectEmail";
import { Service, Container } from "typedi";

const FROM = `EduGo <test@${process.env.MAILGUN_DOMAIN}>`;

type EmailType = "verification" | "reminder" | "added";

//@Service('mailgunemailservice')
export class MailgunEmailService implements EmailService {
	mg: mailgun.Mailgun;

	// handle bar templates
	verificationCodeTemplate: HandlebarsTemplateDelegate<VerificationCodeTemplateObject>;
	verificationReminderTemplate: HandlebarsTemplateDelegate<VerificationCodeTemplateObject>;
	addedToSubjectTemplate: HandlebarsTemplateDelegate<AddedToSubjectTemplateObject>;
	constructor() {
		this.mg = mailgun({
			apiKey: process.env.MAILGUN_API_KEY!,
			domain: process.env.MAILGUN_DOMAIN!,
		});
		const rawVerificationCodeTemplate = fs.readFileSync(
			`${__dirname}/templates/VerificationCode.hbs`,
			"utf-8"
		);
		const rawVerificationReminderTemplate = fs.readFileSync(
			`${__dirname}/templates/VerificationReminder.hbs`,
			"utf-8"
		);
		const rawAddedToSubjectTemplate = fs.readFileSync(
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
	}

	sendOneEmail(to: string, name: string, code: string): void {
		const html = this.verificationCodeTemplate({
			code: code,
			link: `http://localhost:8082/?user=sthenyandeni&code=ABCD`,
		});

		const data: mailgun.messages.SendData = {
			to: to,
			subject: "Verification Code",
			from: FROM,
			html: html,
		};
		console.log(data);
		this.mg
			.messages()
			.send(data)
			.then((result) => {
				console.log(result);
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

		const recipientEmails: string = content
			.map((value) => value.email)
			.join(", ");

		const recipientJSON: any = {};
		let subject = "";

		if (type === "verification" && this.isVerificationEmail(content)) {
			subject = "Verification Code";
			for (let i = 0; i < content.length; i++) {
				recipientJSON[content[i].email] = {
					html: this.verificationCodeTemplate({
						code: content[i].code,
						link: "",
					}),
				};
			}
		} else if (type === "reminder" && this.isVerificationEmail(content)) {
			subject = "Just a little reminder";
			for (let i = 0; i < content.length; i++) {
				recipientJSON[content[i].email] = {
					html: this.verificationReminderTemplate({
						code: content[i].code,
						link: "",
					}),
				};
			}
		} else if (type === "added" && this.isAddedToSubjectEmail(content)) {
			subject = "Another subject";
			for (let i = 0; i < content.length; i++) {
				recipientJSON[content[i].email] = {
					html: this.addedToSubjectTemplate({
						name: content[i].name,
						subject: content[i].subject,
					}),
				};
			}
		} else return false;

		const data: mailgun.messages.BatchData = {
			to: recipientEmails,
			from: FROM,
			subject: subject,
			html: "%recipient.html%",
			"recipient-variables": JSON.stringify(recipientJSON),
		};

		return this.mg
			.messages()
			.send(data)
			.then((result) => true)
			.catch((err) => false);
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

// Container.set('mailgumEmailService', new MailgunEmailService());
