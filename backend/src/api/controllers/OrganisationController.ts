import express from "express";
import { NonExistantItemError } from "../errors/NonExistantItemError";
import { DatabaseError } from "../errors/DatabaseError";
import { AddSubjectToOrganisationRequest } from "../models/organisation/AddSubjectToOrganisationRequest";
import { CreateOrganisationRequest } from "../models/organisation/CreateOrganisationRequest";
import { GetOrganisationRequest } from "../models/organisation/GetOrganisationRequest";
import { OrganisationService } from "../services/OrganisationService";


export const router = express.Router();
const service: OrganisationService = new OrganisationService();

router.post("/createOrganisation", async (req, res) => {
	let body = <CreateOrganisationRequest>req.body;
	service
		.CreateOrganisation(body)
		.then((response) => {
			res.status(200).json(response);
		})
		.catch((err) => {
			if (err instanceof DatabaseError) res.status(500).json(err);
			else if (err instanceof NonExistantItemError)
				res.status(400).json(err);
			else {
			}
		});
});

router.post("/getOrganisations", async (req, res) => {
	service
		.GetOrganisations({})
		.then((response) => {
			res.status(200).json(response);
		})
		.catch((err) => {
			if (err instanceof DatabaseError) res.status(500).json(err);
			else if (err instanceof NonExistantItemError)
				res.status(400).json(err);
			else {
			}
		});
});

router.post("/getOrganisation", async (req, res) => {
	let body = <GetOrganisationRequest>req.body;
	service
		.GetOrganisation(body)
		.then((response) => {
			res.status(200).json(response);
		})
		.catch((err) => {
			if (err instanceof DatabaseError) res.status(500).json(err);
			else if (err instanceof NonExistantItemError)
				res.status(400).json(err);
			else {
			}
		});
});

router.post("/addSubject", async (req, res) => {
	let body = <AddSubjectToOrganisationRequest>req.body;
	service
		.AddSubjectToOrganisation(body)
		.then((response) => {
			res.status(200).json(response);
		})
		.catch((err) => {
			if (err instanceof DatabaseError) res.status(500).json(err);
			else if (err instanceof NonExistantItemError)
				res.status(400).json(err);
			else {
			}
		});
});
