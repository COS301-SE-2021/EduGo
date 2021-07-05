import { MockEmailService } from "../../email/MockEmailService";
import { EmailService } from "../../email/EmailService";

export class EducatorService {
    emailService: EmailService;

    constructor() {
        this.emailService = new MockEmailService();
    }

    public async AddEducators(request)

    private async HandleVerifiedEducators(emails: string[], id: number) {

    }

    private async HandleUnverifiedEducators(emails: string[], id: number) {

    }

    private async HandleNonExistentEducators(emails: string[], id: number) {

    }
} 