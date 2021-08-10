import { Subject } from "../../database/Subject";
import { Organisation } from "./Default";

export interface GetOrganisationResponse extends Organisation {
    id: number;
    subjects: Subject[]; 
}