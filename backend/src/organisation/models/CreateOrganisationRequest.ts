import { RegisterRequest } from "../../api/models/authModels/RegisterRequest";
import { Organisation } from "./Default";

export interface CreateOrganisationRequest extends Organisation, RegisterRequest {

    
}
