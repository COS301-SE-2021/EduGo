import { ApiResponse } from "../../models/apiResponse";
import { AddModelToVirtualEntityFileData } from "../model/AddModelToVirtualEntityRequest";
import { AddModelToVirtualEntityDatabaseResult } from "../model/AddModelToVirtualEntityResponse";
import { CreateVirtualEntityRequest } from "../model/CreateVirtualEntityRequest";
import { CreateVirtualEntityResponse } from "../model/CreateVirtualEntityResponse";
import { GetVirtualEntitiesRequest } from "../model/GetVirtualEntitiesRequest";
import { GetVirtualEntitiesResponse } from "../model/GetVirtualEntitiesResponse";
import { GetVirtualEntityRequest } from "../model/GetVirtualEntityRequest";
import { GetVirtualEntityResponse } from "../model/GetVirtualEntityResponse";

export abstract class VirtualEntityService {
    abstract CreateVirtualEntity(request: CreateVirtualEntityRequest): Promise<CreateVirtualEntityResponse>;
    abstract GetVirtualEntities(request: GetVirtualEntitiesRequest): Promise<GetVirtualEntitiesResponse>;
    abstract GetVirtualEntity(request: GetVirtualEntityRequest): Promise<GetVirtualEntityResponse>;
    abstract AddModelToVirtualEntity(request: AddModelToVirtualEntityFileData): Promise<AddModelToVirtualEntityDatabaseResult>;
}