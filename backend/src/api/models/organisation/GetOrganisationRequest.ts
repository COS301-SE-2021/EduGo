import { IsInt, Min } from "class-validator";

export class GetOrganisationRequest {
    @IsInt()
    @Min(1)
    id: number;
}