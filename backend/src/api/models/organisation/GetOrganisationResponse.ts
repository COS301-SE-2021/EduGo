import { Subject } from "../../../api/database/Subject";
import { Organisation } from "./Default";

export interface GetOrganisationResponse extends Organisation {
    id: number;
    subjects: Subject[]; 
}