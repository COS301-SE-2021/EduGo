import { Model } from "./Default";
export class AddModelToVirtualEntityRequest {
	virtualEntity_id: number;
	name: string;
	description: string;
}

export class AddModelToVirtualEntityFileData extends Model {
	id: number;
}
