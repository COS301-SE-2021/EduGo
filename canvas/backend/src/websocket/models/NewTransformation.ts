import { IsJWT } from "class-validator";

export class NewTransformation {
    @IsJWT()
    token: string;
}