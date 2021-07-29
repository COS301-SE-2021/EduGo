import crypto from "crypto";
import jsonwebtoken from "jsonwebtoken";
import fs from "fs";
import path from "path";
import { User } from "../../database/User";

const pathToKey = path.join(__dirname, "/id_rsa_priv.pem");
const PRIV_KEY = fs.readFileSync(pathToKey, "utf8");

/**
 * -------------- HELPER FUNCTIONS ----------------
 */

/**
 *
 * @param {*} password - The plain text password
 * @param {*} hash - The hash stored in the database
 * @param {*} salt - The salt stored in the database
 *
 * This function uses the crypto library to decrypt the hash using the salt and then compares
 * the decrypted hash/salt with the password that the user provided at login
 */
export function validPassword(password: string, hash: string, salt: string) {
	var hashVerify = crypto
		.pbkdf2Sync(password, salt, 10000, 64, "sha512")
		.toString("hex");
	return hash === hashVerify;
}

/**
 *
 * @param {*} password - The password string that the user inputs to the password field in the register form
 *
 * This function takes a plain text password and creates a salt and hash out of it.  Instead of storing the plaintext
 * password in the database, the salt and hash are stored for security
 *
 * ALTERNATIVE: It would also be acceptable to just use a hashing algorithm to make a hash of the plain text password.
 * You would then store the hashed password in the database and then re-hash it to verify later (similar to what we do here)
 */
export function genPassword(password: string) {
	var salt = crypto.randomBytes(32).toString("hex");
	var genHash = crypto
		.pbkdf2Sync(password, salt, 10000, 64, "sha512")
		.toString("hex");

	return {
		salt: salt,
		hash: genHash,
	};
}

/**
 * @param {*} user - The user object.  We need this to set the JWT `sub` payload property to the Postgre user ID
 */
export function issueJWT(user: User) {
	const expiresIn = "1d";
	let isAdmin = false;

	// check if user is an educator and if they are an admin if they are set admin to true
	if (user.educator !== undefined) {
		if (user.educator.admin) isAdmin = true;
	}

	const payload = {
		user_id: user.id
	};

	const signedToken = jsonwebtoken.sign(payload, PRIV_KEY, {
		expiresIn: expiresIn,
		algorithm: "RS256",
	});

	return {
		token: "Bearer " + signedToken,
	};
}

module.exports.validPassword = validPassword;
module.exports.genPassword = genPassword;
module.exports.issueJWT = issueJWT;
