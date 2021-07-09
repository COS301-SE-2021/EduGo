import { Organisation } from "../../database/entity/Organisation";
import { getRepository } from "typeorm";
import { CreateOrganisationRequest } from "../models/CreateOrganisationRequest";
import { CreateOrganisationResponse } from "../models/CreateOrganisationResponse";
import { GetOrganisationRequest } from "../models/GetOrganisationRequest";
import { GetOrganisationResponse } from "../models/GetOrganisationResponse";
import { GetOrganisationsRequest } from "../models/GetOrganisationsRequest";
import { GetOrganisationsResponse, GOs_Organisation } from "../models/GetOrganisationsResponse";
import { OrganisationService } from "./OrganisationService";
import { DatabaseError } from "../../exceptions/DatabaseError";
import { NonExistantItemError } from "../../exceptions/NonExistantItemError";
import { AddSubjectToOrganisationRequest } from "../models/AddSubjectToOrganisationRequest";
import { AddSubjectToOrganisationResponse } from "../models/AddSubjectToOrganisationResponse";
import { Subject } from "../../database/entity/Subject";

export class OrganisationServiceImplementation implements OrganisationService {
    async AddSubjectToOrganisation(request: AddSubjectToOrganisationRequest): Promise<AddSubjectToOrganisationResponse> {
        let subjectRepo = getRepository(Subject);
        let organisationRepo = getRepository(Organisation);

        return organisationRepo.findOne(request.organisation_id, {relations: ["subjects"]}).then(organisation => {
            if (organisation) {
                return subjectRepo.findOne(request.subject_id).then(subject => {
                    if (subject) {
                        organisation.subjects.push(subject);
                        organisationRepo.save(organisation).then(result => {
                            let response: AddSubjectToOrganisationResponse = {
                                count: result.subjects.length,
                                message: `Added subject ID ${subject.id} to organisation ID ${result.id}`
                            }
                            return response;
                        })
                        .catch(err => {
                            throw new DatabaseError(`Could not add subject ID ${request.subject_id} to organisation ID ${request.organisation_id}`);
                        })
                    }
                    throw new NonExistantItemError(`Subject ID ${request.subject_id} could not be found`);
                })
            }
            throw new NonExistantItemError(`Organisation ID ${request.organisation_id} could not be found`);
        })
        .catch(err => {
            throw new DatabaseError();
        })
    }

    async CreateOrganisation(request: CreateOrganisationRequest): Promise<CreateOrganisationResponse> {
        let organisation: Organisation = new Organisation();
        organisation.name = request.name;
        organisation.email = request.email;
        organisation.phone = request.phone;
        organisation.subjects = [];

        let organisationRepo = getRepository(Organisation);
        return organisationRepo.save(organisation).then(org => {
            let response: CreateOrganisationResponse = {
                id: org.id
            }

            return response;
        }).catch(err => {
            throw new DatabaseError('Could not create a new organisation');
        })
    }

    async GetOrganisation(request: GetOrganisationRequest): Promise<GetOrganisationResponse> {
        let organisationRepo = getRepository(Organisation);
        return organisationRepo.findOne(request.id).then(organisation => {
            if (organisation) {
                let response: GetOrganisationResponse = {
                    ...organisation
                }

                return response;
            }
            throw new NonExistantItemError(`Organisation ID ${request.id} could not be found`);  
        })
        .catch(err => {
            throw new DatabaseError();
        })
    }

    async GetOrganisations(request: GetOrganisationsRequest): Promise<GetOrganisationsResponse> {
        let organisationRepo = getRepository(Organisation);
        return organisationRepo.find().then(organisations => {
            let response: GetOrganisationsResponse = {
                organisations: organisations.map(value => {
                    let organisation: GOs_Organisation = {
                        ...value
                    }
                    return organisation;
                })
            }
            return response;
        })
        .catch(err => {
            throw new DatabaseError();
        })
    }
}