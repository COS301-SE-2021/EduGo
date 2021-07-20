import jwtDecode from "jwt-decode";
import passport from "passport";

export async function isUser(req: any, res: any, next: any) {
	const token = req.headers.authorization.slice(7);
	const payload = jwtDecode(token);
	console.log(payload);
	next();
}

export async function isAdmin(req: any, res: any, next: any) {
	const token = req.headers.authorization.slice(7);
	const payload = jwtDecode(token);
	console.log(payload);
	next();
}

export async function passportJWT() {
	passport.authenticate("jwt", { session: false });
}
