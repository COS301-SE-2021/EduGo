export enum userType{ 
	student = "student", 
	educator= "educator", 
	firstAdmin = "firstTimeAdmin"
}

export interface RegisterRequest {
	organisation_id: number;
	password: any;
	user_firstName: string;
	user_lastName: string;
	user_email: string;
	userType: userType;
	username: string;
}
