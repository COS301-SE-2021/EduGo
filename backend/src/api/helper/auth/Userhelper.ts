import { User } from "../../database/User";
import { getRepository } from "typeorm";
import { DatabaseError } from "pg";
import { NotFoundError } from "routing-controllers";

export async function getUserDetails(user_id: number): Promise<User> {
	return getRepository(User)
		.findOne(user_id, {
			relations: ["organisation", "educator", "student"],
		})
		.then((user) => {
			if (user) {
				return user;
			} else throw new NotFoundError("User not found");
		});
}

export  function generateCode(length: number): string {
	let charset = '0123456789';
	let result = '';
	for (let i = 0; i < length; i++) result += charset[Math.floor(Math.random() * charset.length)];
	return result;
}
