import { RegisterRequest } from "../../auth/models/RegisterRequest";
import { Organisation } from "./Default";

export interface CreateOrganisationRequest extends Organisation, RegisterRequest {

    
}
