import { Model } from "./Default";

export class AddModelToVirtualEntityResponse extends Model {
	virtualEntity_id: number;
	model_id: number;
}

export class AddModelToVirtualEntityDatabaseResult {
	model_id: number;
	thumbnail: string;
}
