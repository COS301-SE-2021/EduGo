const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;

export const validateEmail = (email: string): boolean => {
    return emailRegex.test(email)
}

export const validateEmails = (emails: string[]): boolean => {
    return emails.every(value => validateEmail(value));
}

