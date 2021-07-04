import multer from "multer";
import multerS3 from "multer-s3";
import AWS from "aws-sdk";
import dotenv from "dotenv";

dotenv.config();

AWS.config.update({
	accessKeyId: process.env.AWS_ACCESS_KEY,
	secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
	region: "af-south-1",
});

const s3 = new AWS.S3();

export const uploadFile = multer({
	storage: multerS3({
		s3: s3,
		acl: "public-read",
		bucket: "edugo-files",
		metadata: (req, file, cb) => {
			cb(null, { fieldname: file.fieldname });
		},
		key: (req, file, cb) => {
			cb(null, `${Date.now().toString()}-${file.originalname}`);
		},
	}),
});
