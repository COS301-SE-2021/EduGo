import { Organisation } from "./Default";

export interface GOs_Organisation extends Organisation {
    id: number;
}

export interface GetOrganisationsResponse {
    organisations: GOs_Organisation[];
}