import { VerificationEmail } from "./models/VerificationEmail";

export abstract class EmailService {
    abstract sendOneEmail(to: string, name: string, code: string): void;
    abstract SendBulkVerificationEmails(emails: VerificationEmail[]): boolean;
}