import { ApiResponse } from "../../models/apiResponse";
import { CreateVirtualEntityRequest } from "../model/CreateVirtualEntityRequest";
import { CreateVirtualEntityResponse } from "../model/CreateVirtualEntityResponse";
import { GetVirtualEntitiesRequest } from "../model/GetVirtualEntitiesRequest";
import { GetVirtualEntitiesResponse } from "../model/GetVirtualEntitiesResponse";

export abstract class VirtualEntityService {
    abstract CreateVirtualEntity(request: CreateVirtualEntityRequest): Promise<CreateVirtualEntityResponse>;
    abstract GetVirtualEntities(request: GetVirtualEntitiesRequest): Promise<GetVirtualEntitiesResponse>;
}