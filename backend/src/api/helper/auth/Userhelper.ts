import { User } from "../../../api/database/User";
import { getRepository } from "typeorm";
import { NonExistantItemError } from "../../../api/errors/NonExistantItemError";
import { DatabaseError } from "pg";

export async function getUserDetails(user_id: number): Promise<User> {
	return getRepository(User)
		.findOne({ id: user_id })
		.then((user) => {
			if (user) {
				return user;
			} else throw new NonExistantItemError("User not found");
		});
}
