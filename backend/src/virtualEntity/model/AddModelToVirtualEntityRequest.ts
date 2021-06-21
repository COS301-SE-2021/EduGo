export interface AddModelToVirtualEntityRequest {
    virtualEntity_id: number;
    name: string;
    description: string;
}

export interface AddModelToVirtualEntityFileData {
    id: number;
    name: string;
    description: string;
    file_link: string;
    file_size: number;
    file_type: string;
    file_name: string;
}