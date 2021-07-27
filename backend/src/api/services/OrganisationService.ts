import { AddSubjectToOrganisationRequest } from "../models/organisation/AddSubjectToOrganisationRequest";
import { AddSubjectToOrganisationResponse } from "../models/organisation/AddSubjectToOrganisationResponse";
import { CreateOrganisationRequest } from "../models/organisation/CreateOrganisationRequest";
import { CreateOrganisationResponse } from "../models/organisation/CreateOrganisationResponse";
import { GetOrganisationRequest } from "../models/organisation/GetOrganisationRequest";
import { GetOrganisationResponse } from "../models/organisation/GetOrganisationResponse";
import { GetOrganisationsRequest } from "../models/organisation/GetOrganisationsRequest";

import { Organisation } from "../database/Organisation";
import { getRepository } from "typeorm";

import {
	GetOrganisationsResponse,
	GOs_Organisation,
} from "../models/organisation/GetOrganisationsResponse";

import { DatabaseError } from "../errors/DatabaseError";
import { NonExistantItemError } from "../errors/NonExistantItemError";

import { Subject } from "../database/Subject";
import { RegisterRequest } from "../models/auth/RegisterRequest";
import { AuthService } from "./AuthService";

export class OrganisationService {
	async AddSubjectToOrganisation(
		request: AddSubjectToOrganisationRequest
	): Promise<AddSubjectToOrganisationResponse> {
		let subjectRepo = getRepository(Subject);
		let organisationRepo = getRepository(Organisation);

		return organisationRepo
			.findOne(request.organisation_id, { relations: ["subjects"] })
			.then((organisation) => {
				if (organisation) {
					return subjectRepo
						.findOne(request.subject_id)
						.then((subject) => {
							if (subject) {
								organisation.subjects.push(subject);
								organisationRepo
									.save(organisation)
									.then((result) => {
										let response: AddSubjectToOrganisationResponse =
											{
												count: result.subjects.length,
												message: `Added subject ID ${subject.id} to organisation ID ${result.id}`,
											};
										return response;
									})
									.catch((err) => {
										throw new DatabaseError(
											`Could not add subject ID ${request.subject_id} to organisation ID ${request.organisation_id}`
										);
									});
							}
							throw new NonExistantItemError(
								`Subject ID ${request.subject_id} could not be found`
							);
						});
				}
				throw new NonExistantItemError(
					`Organisation ID ${request.organisation_id} could not be found`
				);
			})
			.catch((err) => {
				throw new DatabaseError();
			});
	}

	async CreateOrganisation(
		request: CreateOrganisationRequest
	): Promise<CreateOrganisationResponse> {
		let organisation: Organisation = new Organisation();
		organisation.name = request.organisation_name;
		organisation.email = request.organisation_email;
		organisation.phone = request.organisation_phone;
		organisation.subjects = [];

		// create organization
		let organisationRepo = getRepository(Organisation);
		
		return organisationRepo
			.save(organisation)
			.then(async (org) => {
				// create first admin for organisation
				request.userType = "OrganizationAdmin";
				request.organisation_id = org.id;
				let registerObj: RegisterRequest = {
					...request,
				};
				let authService = new AuthService();

				try {
					await authService.register(registerObj);
					let response: CreateOrganisationResponse = {
						id: org.id,
					};
					return response;
				} catch (error) {
					throw error;
				}
			})
			.catch((err) => {
				throw err;
			});
	}

	async GetOrganisation(
		request: GetOrganisationRequest
	): Promise<GetOrganisationResponse> {
		let organisationRepo = getRepository(Organisation);
		return organisationRepo
			.findOne(request.id)
			.then((organisation) => {
				if (organisation) {
					let response: GetOrganisationResponse = {
						organisation_email: organisation.email,
						organisation_name: organisation.name,
						organisation_phone: organisation.phone,
						id: organisation.id,
					};

					return response;
				}
				throw new NonExistantItemError(
					`Organisation ID ${request.id} could not be found`
				);
			})
			.catch((err) => {
				throw new DatabaseError(err.message);
			});
	}

	async GetOrganisations(
		request: GetOrganisationsRequest
	): Promise<GetOrganisationsResponse> {
		let organisationRepo = getRepository(Organisation);
		return organisationRepo
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
			.catch((err) => {
				throw new DatabaseError();
			});
	}
}
