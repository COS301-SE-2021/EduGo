import { RegisterRequest } from "../authInterfaces/RegisterRequest";
import { Organisation } from "./Default";

export interface CreateOrganisationRequest extends Organisation, RegisterRequest {

    
}
