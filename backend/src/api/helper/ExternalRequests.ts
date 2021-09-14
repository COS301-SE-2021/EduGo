import axios from "axios";
import { InternalServerError } from "routing-controllers";

export const GenerateThumbnail = async (url: string) => {
	return axios
		.post(process.env.GENERATE_THUMBNAIL_URL!, { url })
		.then((response) => {
			if (response.status === 200) {
				return response.data as { download: string; uploaded: string };
			}
			console.log(response.data);
			throw new InternalServerError("Error while generating thumbnail");
		})
		.catch((error) => {
			console.log(error);
			throw new InternalServerError(
				"There was an error calling the generate thumbnail endpoint"
			);
		});
};
