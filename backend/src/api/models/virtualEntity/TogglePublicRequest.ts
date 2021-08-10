import { IsInt, Min } from 'class-validator';

export class TogglePublicRequest {
    @IsInt()
    @Min(1)
    id: number;
}   