import { EmailService } from "./EmailService";
import { AddedToSubjectEmail } from "./models/AddedToSubjectEmail";
import { VerificationEmail } from "./models/VerificationEmail";
import { Service, Container } from "typedi";

// @Service({id:'mockEmailService'})
export class MockEmailService implements EmailService {
	sendOneEmail(to: string, name: string, code: string): void {
		throw new Error("Method not implemented.");
	}
	async SendBulkVerificationEmails(
		emails: VerificationEmail[]
	): Promise<boolean> {
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

// Container.set('mockEmailService', new MockEmailService());
