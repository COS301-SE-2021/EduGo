import multer from "multer";
import { Readable } from "stream";
import { BadRequestError, InternalServerError } from "routing-controllers";
import azurestorage from "azure-storage";
import { Inject, Service } from "typedi";

const inMemoryStorage = multer.memoryStorage();
export const upload = multer({ storage: inMemoryStorage });

@Service()
export class FileManagement {
	constructor(@Inject() private blobService: azurestorage.BlobService) {}

	private getBlobName(originalName: string) {
		const identifier = Math.random().toString().replace(/0\./, ""); // remove "0." from start of string
		return `${identifier}-${originalName}`;
	}

	public async UploadImageToAzure(
		file: Express.Multer.File
	): Promise<string> {
		const allowedExtensions = ["jpg", "jpeg", "png"];
		return new Promise<string>((resolve, reject) => {
			if (!this.ValidateExtension(file.originalname, allowedExtensions)) {
				reject(
					`Invalid file extension. Only supported: ${allowedExtensions.join(
						", "
					)}`
				);
				throw new BadRequestError(
					`Invalid file extension. Only supported: ${allowedExtensions.join(
						", "
					)}`
				);
			}
			const name = this.getBlobName(file.originalname);
			const length = file.buffer.length || 0;
			const stream = new Readable();
			stream.push(file.buffer);
			stream.push(null);

			this.blobService.createBlockBlobFromStream(
				"edugo",
				`images/${name}`,
				stream,
				length,
				(err, result, response) => {
					if (err) {
						console.log(err);
						reject(err);
						throw new InternalServerError(
							"There was an error uploading the file"
						);
					}

					resolve(this.blobService.getUrl("edugo", `images/${name}`));
				}
			);
		});
	}

	public async UploadModelToAzure(
		file: Express.Multer.File
	): Promise<string> {
		const allowedExtensions = ["glb"];
		return new Promise<string>((resolve, reject) => {
			if (!this.ValidateExtension(file.originalname, allowedExtensions)) {
				reject(
					`Invalid file extension. Only supported: ${allowedExtensions.join(
						", "
					)}`
				);
				throw new BadRequestError(
					`Invalid file extension. Only supported: ${allowedExtensions.join(
						", "
					)}`
				);
			}
			const name = this.getBlobName(file.originalname);
			const length = file.buffer.length || 0;
			const stream = new Readable();
			stream.push(file.buffer);
			stream.push(null);

			this.blobService.createBlockBlobFromStream(
				"edugo",
				`models/${name}`,
				stream,
				length,
				(err, result, response) => {
					if (err) {
						console.log(err);
						reject(err);
						throw new InternalServerError(
							"There was an error uploading the file"
						);
					}

					resolve(this.blobService.getUrl("edugo", `models/${name}`));
				}
			);
		});
	}

	private GetExtension(filename: string): string {
		return filename.slice(
			(Math.max(0, filename.lastIndexOf(".")) || Infinity) + 1
		);
	}

	private ValidateExtension(
		filename: string,
		allowedExtensions: string[]
	): boolean {
		const extension = this.GetExtension(filename);
		return allowedExtensions.includes(extension);
	}
}
