import seed from "./seed.json";
import express from "express";
import { getRepository } from "typeorm";
import { Organisation } from "./database/entity/Organisation";
import { User } from "./database/entity/User";
import { Student } from "./database/entity/Student";
import { Educator } from "./database/entity/Educator";
import { UnverifiedUser, UserType } from "./database/entity/UnverifiedUser";
import { verifyInvitation } from "./auth/service/authService";

const router = express.Router();

router.post("/hidden/seed", async (req, res) => {
	let organisationRepository = getRepository(Organisation);
	let userRepository = getRepository(User);

	let organisations: Organisation[] = seed.organisation.map((value) => {
		let organisation: Organisation = new Organisation();
		organisation.id = value.id;
		organisation.name = value.name;
		organisation.email = value.email;
		organisation.phone = value.phone;

		return organisation;
	});

	let orgLength = organisations.length;

	// unverifies users created
	let userType: UserType;
	let invitedUsers: any[] = seed.invitedUsers.map(
		async (value, index) => {
			let invitedUser: UnverifiedUser = new UnverifiedUser();
			invitedUser.email = value.email;

			invitedUser.type = <UserType>value.type;

			let org = await organisationRepository.findOne(
				value.organization_id
			);
			if (org)
			{
				invitedUser.organisation = org;
				invitedUser.verificationCode = value.verificationCode;
				return invitedUser;
			} 

		
		}
	);

	
	getRepository(UnverifiedUser).save(<UnverifiedUser[]>invitedUsers);

	
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

	organisationRepository.save(organisations).then((savedOrgs) => {
		userRepository.save(users).then((savedUsers) => {
			let response = {
				org_count: savedOrgs.length,
				user_count: savedUsers.length,
			};
			res.status(200).json(response);
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

export { router };
