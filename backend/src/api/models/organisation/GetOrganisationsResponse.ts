// import { Organisation } from "./Default";
// import { Subject } from "../../database/Subject";

// export interface GOs_Organisation extends Organisation {
//     id: number;
// 	subjects: Subject[];
// 	educator: educatorDetails[];
// }

// export interface GetOrganisationsResponse {
//     organisations: GOs_Organisation[];
// }

// export interface educatorDetails {
// 	firstName: string;
// 	lastName: string;
// 	username: string;
//     isAdmin: boolean; 
// }

import { Organisation } from "./Default";

export interface GOs_Organisation extends Organisation {
    id: number;
}

export interface GetOrganisationsResponse {
    organisations: GOs_Organisation[];
}