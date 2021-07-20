import { AddModelToVirtualEntityFileData } from "../interfaces/virtualEntityInterfaces/AddModelToVirtualEntityRequest";
import { AddModelToVirtualEntityDatabaseResult } from "../interfaces/virtualEntityInterfaces/AddModelToVirtualEntityResponse";
import { CreateVirtualEntityRequest } from "../interfaces/virtualEntityInterfaces/CreateVirtualEntityRequest";
import { CreateVirtualEntityResponse } from "../interfaces/virtualEntityInterfaces/CreateVirtualEntityResponse";
import { GetVirtualEntitiesRequest } from "../interfaces/virtualEntityInterfaces/GetVirtualEntitiesRequest";
import { GetVirtualEntitiesResponse } from "../interfaces/virtualEntityInterfaces/GetVirtualEntitiesResponse";
import { GetVirtualEntityRequest } from "../interfaces/virtualEntityInterfaces/GetVirtualEntityRequest";
import { GetVirtualEntityResponse } from "../interfaces/virtualEntityInterfaces/GetVirtualEntityResponse";

export abstract class VirtualEntityService {
    abstract CreateVirtualEntity(request: CreateVirtualEntityRequest): Promise<CreateVirtualEntityResponse>;
    abstract GetVirtualEntities(request: GetVirtualEntitiesRequest): Promise<GetVirtualEntitiesResponse>;
    abstract GetVirtualEntity(request: GetVirtualEntityRequest): Promise<GetVirtualEntityResponse>;
    abstract AddModelToVirtualEntity(request: AddModelToVirtualEntityFileData): Promise<AddModelToVirtualEntityDatabaseResult>;
}