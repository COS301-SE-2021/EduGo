import { IsInt, IsJWT, IsString, Min } from "class-validator";

export class Init {
    @IsInt()
    @Min(1)
    virtualEntityId: number;

    @IsString()
    @IsJWT()
    token: string;
}