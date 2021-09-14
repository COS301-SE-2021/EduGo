import { RegisterRequest } from "../auth/RegisterRequest";
import { Organisation } from "./Default";

export interface CreateOrganisationRequest
	extends Organisation,
		RegisterRequest {}
