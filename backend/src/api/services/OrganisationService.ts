import { AddSubjectToOrganisationRequest } from "../interfaces/organisationInterfaces/AddSubjectToOrganisationRequest";
import { AddSubjectToOrganisationResponse } from "../interfaces/organisationInterfaces/AddSubjectToOrganisationResponse";
import { CreateOrganisationRequest } from "../interfaces/organisationInterfaces/CreateOrganisationRequest";
import { CreateOrganisationResponse } from "../interfaces/organisationInterfaces/CreateOrganisationResponse";
import { GetOrganisationRequest } from "../interfaces/organisationInterfaces/GetOrganisationRequest";
import { GetOrganisationResponse } from "../interfaces/organisationInterfaces/GetOrganisationResponse";
import { GetOrganisationsRequest } from "../interfaces/organisationInterfaces/GetOrganisationsRequest";
import { GetOrganisationsResponse } from "../interfaces/organisationInterfaces/GetOrganisationsResponse";

export abstract class OrganisationService {
    abstract CreateOrganisation(request: CreateOrganisationRequest): Promise<CreateOrganisationResponse>;
    abstract GetOrganisation(request: GetOrganisationRequest): Promise<GetOrganisationResponse>;
    abstract GetOrganisations(request: GetOrganisationsRequest): Promise<GetOrganisationsResponse>;
    abstract AddSubjectToOrganisation(request: AddSubjectToOrganisationRequest): Promise<AddSubjectToOrganisationResponse>;
}