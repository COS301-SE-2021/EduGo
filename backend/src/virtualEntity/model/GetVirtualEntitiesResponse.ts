export interface GVEs_Model {
    id: number;
    name: string;
    description: string;
    file_link: string;
    file_size: number;
    file_type: string;
    file_name: string;
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