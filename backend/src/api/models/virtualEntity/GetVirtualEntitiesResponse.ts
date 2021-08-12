import { Model } from "./Default";
export class GVEs_Model extends Model {
	id: number;
}

export class GVEs_VirtualEntity {
	id: number;
	title: string;
	description: string;
	model?: GVEs_Model;
}

export class GetVirtualEntitiesResponse {
	entities: GVEs_VirtualEntity[];
}
