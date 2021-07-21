import { AddedToSubjectEmail } from "./models/AddedToSubjectEmail";
import { VerificationEmail } from "./models/VerificationEmail";

export abstract class EmailService {
    abstract sendOneEmail(to: string, name: string, code: string): void;
    abstract SendBulkVerificationEmails(emails: VerificationEmail[]): Promise<boolean>;
    abstract SendBulkVerificationReminderEmails(emails: VerificationEmail[]): Promise<boolean>;
    abstract SendBulkAddedToSubjectEmails(emails: AddedToSubjectEmail[]): Promise<boolean>;
}