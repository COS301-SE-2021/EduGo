import { IsInt, Min }  from 'class-validator';

export class GetVirtualEntityRequest {
    @IsInt()
    @Min(1)
    virtualEntityId: number;
}