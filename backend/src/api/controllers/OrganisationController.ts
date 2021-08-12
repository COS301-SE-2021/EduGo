import { AddSubjectToOrganisationRequest } from "../models/organisation/AddSubjectToOrganisationRequest"
import { CreateOrganisationRequest } from "../models/organisation/CreateOrganisationRequest";
import { GetOrganisationRequest } from "../models/organisation/GetOrganisationRequest";
import { OrganisationService } from "../services/OrganisationService";
import { Inject, Service } from "typedi";
import { Body, JsonController, Post } from "routing-controllers";
import { GetOrganisationsRequest } from "../models/organisation/GetOrganisationsRequest";

@Service()
@JsonController("/organisation")
export class OrganisationController {
	@Inject()
	private service: OrganisationService;

	@Post("/createOrganisation")
	CreateOrganisation(
		@Body({ required: true }) body: CreateOrganisationRequest
	) {
		return this.service.CreateOrganisation(body);
	}
	@Post("/getOrganisations")
	GetOrganisations(@Body({ required: true }) body: GetOrganisationsRequest) {
		return this.service.GetOrganisations(body);
	}

	@Post("/getOrganisation")
	GetOrganisation(@Body({ required: true }) body: GetOrganisationRequest) {
		return this.service.GetOrganisation(body);
	}

	@Post("/addSubjectToOrganisation")
	AddSubjectToOrganisation(
		@Body({ required: true }) body: AddSubjectToOrganisationRequest
	) {
		return this.service.AddSubjectToOrganisation(body);
	}
}

