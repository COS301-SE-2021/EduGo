import { AddSubjectToOrganisationRequest } from "../models/organisation/AddSubjectToOrganisationRequest";
import { AddSubjectToOrganisationResponse } from "../models/organisation/AddSubjectToOrganisationResponse";
import { CreateOrganisationRequest } from "../models/organisation/CreateOrganisationRequest";
import { CreateOrganisationResponse } from "../models/organisation/CreateOrganisationResponse";
import { GetOrganisationRequest } from "../models/organisation/GetOrganisationRequest";
import { GetOrganisationResponse } from "../models/organisation/GetOrganisationResponse";
import { GetOrganisationsRequest } from "../models/organisation/GetOrganisationsRequest";

import { Organisation } from "../database/Organisation";
import { Repository } from "typeorm";

import {
	GetOrganisationsResponse,
	GOs_Organisation,
} from "../models/organisation/GetOrganisationsResponse";

import { Subject } from "../database/Subject";
import { RegisterRequest, userType } from "../models/auth/RegisterRequest";
import { AuthService } from "./AuthService";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { Inject, Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { BadRequestError, InternalServerError, NotFoundError } from "routing-controllers";

@Service()
export class OrganisationService {

	@InjectRepository(Organisation)
	private organisationRepository: Repository<Organisation>;

	@InjectRepository(Subject) 
	private subjectRepository: Repository<Subject>;

	@Inject()
	private authService: AuthService;

/**
 * @description Subjects that have already been created can be added to an  new organisation 
 * @param {AddSubjectToOrganisationRequest} request
 * @returns   {Promise<AddSubjectToOrganisationResponse>}
 * @memberof OrganisationService
 */
async AddSubjectToOrganisation(request: AddSubjectToOrganisationRequest): Promise<AddSubjectToOrganisationResponse> {
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
										let response: AddSubjectToOrganisationResponse =
											{
												count: result.subjects.length,
												message: `Added subject ID ${subject.id} to organisation ID ${result.id}`,
											};
										return response;
									})
									.catch(() => {
										throw new InternalServerError(`Could not add subject ID ${request.subject_id} to organisation ID ${request.organisation_id}`);
									});
							}
							throw new BadRequestError(`Subject ID ${request.subject_id} could not be found`);
						});
				}
				throw new BadRequestError(`Organisation ID ${request.organisation_id} could not be found`);
			})
			.catch((err) => {throw new InternalServerError(err.message);});
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
		let organisation: Organisation = new Organisation();
		organisation.name = request.organisation_name;
		organisation.email = request.organisation_email;
		organisation.phone = request.organisation_phone;
		organisation.subjects = [];


		return this.organisationRepository
			.save(organisation)
			.then(async (org) => {
				request.userType = userType.firstAdmin;
				request.organisation_id = org.id;
				let registerObj: RegisterRequest = {
					...request,
				};

				try {
					await this.authService.register(registerObj);
					let response: CreateOrganisationResponse = {
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
			.findOne(request.id, { relations: ["subjects"] })
			.then((organisation) => {
				if (organisation) {
					let response: GetOrganisationResponse = {
						organisation_email: organisation.email,
						organisation_name: organisation.name,
						organisation_phone: organisation.phone,
						id: organisation.id,
						subjects: organisation.subjects,
					};

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
	async GetOrganisations(request: GetOrganisationsRequest): Promise<GetOrganisationsResponse> {
		return this.organisationRepository
			.find()
			.then((organisations) => {
				let response: GetOrganisationsResponse = {
					organisations: organisations.map((value) => {
						let organisation: GOs_Organisation = {
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
				throw new InternalServerError('');
			});
	}
}
