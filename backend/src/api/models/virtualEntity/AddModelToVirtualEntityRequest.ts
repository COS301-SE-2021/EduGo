import {Model} from './Default';
export interface AddModelToVirtualEntityRequest {
    virtualEntity_id: number;
    name: string;
    description: string;
}

export interface AddModelToVirtualEntityFileData extends Model {
    id: number;
}