export abstract class EmailService {
    abstract sendOneEmail(to: string, name: string, code: string): void;
}