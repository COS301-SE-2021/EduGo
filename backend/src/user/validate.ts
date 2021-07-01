const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;

export const validateEmail = (email: string): boolean => {
    return emailRegex.test(email)
}