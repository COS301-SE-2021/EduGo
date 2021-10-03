import axios from "axios";
import { InternalServerError } from "routing-controllers";
import { Service } from "typedi";

@Service()
export class ExternalRequests {
	async GenerateThumbnail(url: string) {
		return axios
			.post(process.env.GENERATE_THUMBNAIL_URL!, { url })
			.then((response) => {
				if (response.status === 200) {
					return response.data as {
						download: string;
						uploaded: string;
					};
				}
				console.log(response.data);
				throw new InternalServerError(
					"Error while generating thumbnail"
				);
			})
			.catch((error) => {
				console.log(error);
				throw new InternalServerError(
					"There was an error calling the generate thumbnail endpoint"
				);
			});
	}

	async ConvertModel(url: string) {
		return axios
			.post(process.env.CONVERTER_URL!, { url })
			.then((response) => {
				if (response.status === 200) {
					return response.data as string[];
				}
				throw new InternalServerError(
					`Error while converting model\nHTTP Code: ${response.status}\nResponse: ${response.data}`
				);
			})
			.catch((error) => {
				console.log(error);
				throw new InternalServerError(
					"There was an error calling the converter endpoint"
				);
			});
	}
}
