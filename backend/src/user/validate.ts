const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;

export const validateEmail = (email: string): boolean => {
    return emailRegex.test(email);
}