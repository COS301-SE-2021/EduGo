import { AddSubjectToOrganisationRequest } from "../models/AddSubjectToOrganisationRequest";
import { AddSubjectToOrganisationResponse } from "../models/AddSubjectToOrganisationResponse";
import { CreateOrganisationRequest } from "../models/CreateOrganisationRequest";
import { CreateOrganisationResponse } from "../models/CreateOrganisationResponse";
import { GetOrganisationRequest } from "../models/GetOrganisationRequest";
import { GetOrganisationResponse } from "../models/GetOrganisationResponse";
import { GetOrganisationsRequest } from "../models/GetOrganisationsRequest";
import { GetOrganisationsResponse } from "../models/GetOrganisationsResponse";

export abstract class OrganisationService {
    abstract CreateOrganisation(request: CreateOrganisationRequest): Promise<CreateOrganisationResponse>;
    abstract GetOrganisation(request: GetOrganisationRequest): Promise<GetOrganisationResponse>;
    abstract GetOrganisations(request: GetOrganisationsRequest): Promise<GetOrganisationsResponse>;
    abstract AddSubjectToOrganisation(request: AddSubjectToOrganisationRequest): Promise<AddSubjectToOrganisationResponse>;
}