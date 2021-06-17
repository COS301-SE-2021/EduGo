export interface AddModelToVirtualEntityResponse {
    virtualEntity_id: number;
    model_id: number;
    name: string;
    description: string;
    file_link: string;
    file_size: number;
    file_type: string;
    file_name: string;
}

export interface AddModelToVirtualEntityDatabaseResult {
    model_id: number;
}