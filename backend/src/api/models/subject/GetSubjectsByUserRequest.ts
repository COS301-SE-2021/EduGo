import { IsInt, Min } from 'class-validator';


export class GetSubjectsByUserRequest {
	@IsInt()
	@Min(1)
	user_id: number;
}
