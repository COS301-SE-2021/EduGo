import {Model} from './Default'
export interface GVEs_Model extends Model {
    id: number;
}

export interface GVEs_VirtualEntity {
    id: number;
    title: string;
    description: string;
    model?: GVEs_Model;
}

export interface GetVirtualEntitiesResponse {
    entities: GVEs_VirtualEntity[];
}