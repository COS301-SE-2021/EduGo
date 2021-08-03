import {Model} from './Default'

export interface AddModelToVirtualEntityResponse extends Model {
    virtualEntity_id: number;
    model_id: number;
}

export interface AddModelToVirtualEntityDatabaseResult {
    model_id: number;
}