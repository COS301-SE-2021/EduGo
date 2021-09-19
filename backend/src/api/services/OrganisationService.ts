/* eslint-disable no-useless-catch */
import { AddSubjectToOrganisationRequest } from "../models/organisation/AddSubjectToOrganisationRequest";
import { AddSubjectToOrganisationResponse } from "../models/organisation/AddSubjectToOrganisationResponse";
import { CreateOrganisationRequest } from "../models/organisation/CreateOrganisationRequest";
import { CreateOrganisationResponse } from "../models/organisation/CreateOrganisationResponse";
import { GetOrganisationRequest } from "../models/organisation/GetOrganisationRequest";
import {
	GetOrganisationResponse,
	educatorDetails,
} from "../models/organisation/GetOrganisationResponse";

import { Organisation } from "../database/Organisation";
import { In, Repository } from "typeorm";

import {
	GetOrganisationsResponse,
	GOs_Organisation,
} from "../models/organisation/GetOrganisationsResponse";

import { Subject } from "../database/Subject";
import { RegisterRequest, userType } from "../models/auth/RegisterRequest";
import AuthService from "./AuthService";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { Inject, Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import {
	BadRequestError,
	InternalServerError,
	NotFoundError,
} from "routing-controllers";
import { User } from "../database/User";

@Service()
export class OrganisationService {
	@InjectRepository(Organisation)
	private organisationRepository: Repository<Organisation>;

	@InjectRepository(Subject)
	private subjectRepository: Repository<Subject>;

	@InjectRepository(User)
	private userRepository: Repository<User>;

	@Inject()
	private authService: AuthService;

	/**
	 * @description Subjects that have already been created can be added to an  new organisation
	 * @param {AddSubjectToOrganisationRequest} request
	 * @returns   {Promise<AddSubjectToOrganisationResponse>}
	 * @memberof OrganisationService
	 */
	async AddSubjectToOrganisation(
		request: AddSubjectToOrganisationRequest
	): Promise<AddSubjectToOrganisationResponse> {
		return this.organisationRepository
			.findOne(request.organisation_id, { relations: ["subjects"] })
			.then((organisation) => {
				if (organisation) {
					return this.subjectRepository
						.findOne(request.subject_id)
						.then((subject) => {
							if (subject) {
								organisation.subjects.push(subject);
								this.organisationRepository
									.save(organisation)
									.then((result) => {
										const response: AddSubjectToOrganisationResponse =
											{
												count: result.subjects.length,
												message: `Added subject ID ${subject.id} to organisation ID ${result.id}`,
											};
										return response;
									})
									.catch(() => {
										throw new InternalServerError(
											`Could not add subject ID ${request.subject_id} to organisation ID ${request.organisation_id}`
										);
									});
							}
							throw new BadRequestError(
								`Subject ID ${request.subject_id} could not be found`
							);
						});
				}
				throw new BadRequestError(
					`Organisation ID ${request.organisation_id} could not be found`
				);
			})
			.catch((err) => {
				throw new InternalServerError(err.message);
			});
	}
	/**
	 * @description The creation of an organisation
	 * First create the Orgainisation object
	 * Call the register function that will register the first admin user for the organisation
	 * @param {CreateOrganisationRequest} request
	 * @returns   {Promise<CreateOrganisationResponse>}
	 * @memberof OrganisationService
	 */
	async CreateOrganisation(
		request: CreateOrganisationRequest
	): Promise<CreateOrganisationResponse> {
		const organisation: Organisation = new Organisation();
		organisation.name = request.organisation_name;
		organisation.email = request.organisation_email;
		organisation.phone = request.organisation_phone;
		organisation.subjects = [];

		return this.organisationRepository
			.save(organisation)
			.then(async (org) => {
				request.userType = userType.firstAdmin;
				request.organisation_id = org.id;
				const registerObj: RegisterRequest = {
					...request,
				};

				try {
					await this.authService.register(registerObj);
					const response: CreateOrganisationResponse = {
						id: org.id,
					};
					return response;
				} catch (error) {
					throw error;
				}
			})
			.catch((err) => {
				throw handleSavetoDBErrors(err);
			});
	}
	/**
	 * @description Get information about an organisation just by providing the organisation id
	 * @param {GetOrganisationRequest} request
	 * @returns   {Promise<GetOrganisationResponse>}
	 * @memberof OrganisationService
	 */
	async GetOrganisation(
		request: GetOrganisationRequest
	): Promise<GetOrganisationResponse> {
		return this.organisationRepository
			.findOne(request.id, { relations: ["subjects", "users"] })
			.then(async (organisation) => {
				if (organisation) {
					const response: GetOrganisationResponse = {
						organisation_email: organisation.email,
						organisation_name: organisation.name,
						organisation_phone: organisation.phone,
						id: organisation.id,
						subjects: organisation.subjects,
						educator: [],
					};

					const ids = organisation.users.map((user) => user.id);

					const users: User[] = await (
						await this.userRepository.find({
							where: { id: In(ids) },
							relations: ["educator"],
						})
					).filter((user) => user.educator != undefined);
					const educators: educatorDetails[] = users.map((user) => {
						const populatedUserDetails: educatorDetails = {
							username: user.username,
							firstName: user.lastName,
							lastName: user.lastName,
							isAdmin: user.educator.admin,
						};
						console.log(populatedUserDetails);
						return populatedUserDetails;
					});
					console.log(educators);

					for (let i = 0; i < educators.length; i++) {
						response.educator.push(educators[i]);
					}
					return response;
				}
				throw new BadRequestError(
					`Organisation ID ${request.id} could not be found`
				);
			})
			.catch((err) => {
				throw new BadRequestError(err.message);
			});
	}
	/**
	 * @description Returns basic information about all the organisations on the platform
	 * @param {GetOrganisationsRequest} request
	 * @returns {Promise<GetOrganisationsResponse>}
	 * @memberof OrganisationService
	 */
	async GetOrganisations(): Promise<GetOrganisationsResponse> {
		return this.organisationRepository
			.find()
			.then((organisations) => {
				const response: GetOrganisationsResponse = {
					organisations: organisations.map((value) => {
						const organisation: GOs_Organisation = {
							organisation_email: value.email,
							organisation_name: value.name,
							organisation_phone: value.phone,
							id: value.id,
						};
						return organisation;
					}),
				};
				return response;
			})
			.catch(() => {
				throw new InternalServerError("");
			});
	}
}
