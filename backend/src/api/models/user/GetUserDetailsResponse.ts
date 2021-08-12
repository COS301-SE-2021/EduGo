import { UserType } from "../../../api/database/UnverifiedUser";

export interface GetUserDetailsResponse{
    "organisation_id":number; 
    "userType": UserType; 
    "firstName": string; 
    "lastName": string; 
    "email": string; 
    "username": string;
}