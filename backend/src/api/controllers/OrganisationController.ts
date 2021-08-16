import { AddSubjectToOrganisationRequest } from "../models/organisation/AddSubjectToOrganisationRequest";
import { CreateOrganisationRequest } from "../models/organisation/CreateOrganisationRequest";
import { GetOrganisationRequest } from "../models/organisation/GetOrganisationRequest";
import { OrganisationService } from "../services/OrganisationService";
import { Inject, Service } from "typedi";
import { Body, JsonController, Post, UseBefore } from "routing-controllers";
import { GetOrganisationsRequest } from "../models/organisation/GetOrganisationsRequest";
import { isUser } from "../middleware/validate";
import passport from "passport";

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
	//@UseBefore(passport.authenticate("jwt", { session: false }))
	//@UseBefore(isUser)
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
