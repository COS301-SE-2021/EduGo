import { Subject } from "../../database/Subject";
import { Organisation } from "./Default";

export interface GetOrganisationResponse extends Organisation {
	id: number;
	subjects: Subject[];
	educator: educatorDetails[];
}

export interface educatorDetails {
	firstName: string;
	lastName: string;
	username: string;
    isAdmin: boolean; 
}
