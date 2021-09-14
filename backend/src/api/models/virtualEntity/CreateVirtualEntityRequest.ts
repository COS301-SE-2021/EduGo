import { Type } from 'class-transformer';
import { IsArray, IsBoolean, IsOptional, IsString, ValidateNested } from 'class-validator';
import {Quiz, Model} from './Default';

export class CreateVirtualEntityRequest {
    @IsString()
    title: string;

    @Type(() => Quiz)
    @ValidateNested()
    quiz: Quiz;

    @IsOptional()
    @Type(() => Model)
    model?: Model;

    @IsOptional()
    @IsBoolean()
    public?: boolean;

    @IsOptional()
    @IsArray()
    description?: string[];
}