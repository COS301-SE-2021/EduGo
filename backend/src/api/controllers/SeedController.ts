import seed from "../helper/seed.json";
import express from "express";
import { getConnection, getRepository } from "typeorm";
import { Organisation } from "../Database/Organisation";
import { User } from "../Database/User";
import { Student } from "../Database/Student";
import { Educator } from "../Database/Educator";
import { UnverifiedUser, UserType } from "../Database/UnverifiedUser";

const router = express.Router();

router.post("/hidden/seed", async (req, res) => {
	const entities = getConnection().entityMetadatas;

	// // clear all the tables before seeding
	// for (const entity of entities) {
	// 	const repository = getConnection().getRepository(entity.name); // Get repository
	// 	await repository.clear(); // Clear each entity table's content
	// }

	let organisationRepository = getRepository(Organisation);
	let userRepository = getRepository(User);
	let invitedUserRepo = getRepository(UnverifiedUser);
	let organisations: Organisation[] = seed.organisation.map((value) => {
		let organisation: Organisation = new Organisation();
		organisation.id = value.id;
		organisation.name = value.name;
		organisation.email = value.email;
		organisation.phone = value.phone;

		return organisation;
	});

	let orgLength = organisations.length;

	let users: User[] = seed.user.map((value, index) => {
		let user: User = new User();
		user.id = value.id;
		user.username = value.username;
		user.firstName = value.firstName;
		user.lastName = value.lastName;
		user.email = value.email;
		user.hash = "";
		user.salt = "";
		if (index % 2 === 0) {
			//Is student
			user.student = new Student();
		} else {
			//Is educator
			user.educator = new Educator();
			user.educator.admin = false;
		}
		user.organisation =
			organisations[Math.floor(Math.random() * orgLength)];
		return user;
	});

	// save organizations and users to a table
	organisationRepository
		.save(organisations)
		.then(() => {
			userRepository
				.save(users)
				.then((users) => {
					if (!users) {
						res.status(400);
						return;
					} else {
						addInvitedUsersToDB(res);
					}
				})
				.catch((err) => {
					console.log(err);
					res.status(400).json({
						Return: "Users not saved",
						errorMessage: err.message,
					});
				});
		})
		.catch((err) => {
			console.log(err);
			res.status(400).json({
				Return: "Organizations not saved",
				errorMessage: err.message,
			});
		});
});

router.get("/hidden/seed", async (req, res) => {
	let organisationRepository = getRepository(Organisation);
	let userRepository = getRepository(User);

	// userRepository.findByIds([1,2,3,4,5,6,7,8], {relations: ['organisation']}).then(users => {
	//     res.status(200).json(users);
	// })

	organisationRepository
		.findByIds([1, 2], {
			relations: ["users", "users.student", "users.educator"],
		})
		.then((orgs) => {
			res.status(200).json(orgs);
		});
});

function addInvitedUsersToDB(res: any) {
	let organisationRepository = getRepository(Organisation);
	let invitedUserRepo = getRepository(UnverifiedUser);
	let invitedUsers: UnverifiedUser[] = seed.invitedUsers.map(
		(value, index) => {
			let invitedUser: UnverifiedUser = new UnverifiedUser();
			invitedUser.email = value.email;
			invitedUser.id = value.id;
			invitedUser.type = <UserType>value.type;
			invitedUser.verificationCode = value.verificationCode;
			organisationRepository
				.findOne(value.organization_id)
				.then((org) => {
					if (org) invitedUser.organisation = org;
				})
				.catch((err) => {
					console.log(err);
					res.status(400).json({
						Return: "Organization given not found",
						errorMessage: err.message,
					});
				});
			return invitedUser;
		}
	);
	console.log(invitedUsers);
	invitedUserRepo
		.save(invitedUsers)
		.then((invitedUse) => {
			if (invitedUse) {
				let response = {
					invited_count: invitedUse.length,
				};
				res.status(200).json(response);
			} else {
				res.status(400).json({ Return: "invited user not saves" });
			}
		})
		.catch((err) => {
			console.log(err);
			res.status(400).json({
				Return: "Invited Users given not added",
				errorMessage: err.message,
			});
		});
}
export { router };
