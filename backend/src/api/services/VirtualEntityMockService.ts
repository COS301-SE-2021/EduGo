import { GetTestModelsResponse, TestModel} from "../models/virtualEntity/GetTestModelsResponse";

export class VirtualEntityMockService {
    async GetTestModels(): Promise<GetTestModelsResponse> {
        let models: TestModel[] = [
            {
                name: 'Totoro',
                link: 'https://edugo-files.s3.af-south-1.amazonaws.com/test_models/Totoro.glb'
            },
            {
                name: 'Duck',
                link: 'https://edugo-files.s3.af-south-1.amazonaws.com/test_models/Duck.glb'
            },
            {
                name: 'BeanBag',
                link: 'https://edugo-files.s3.af-south-1.amazonaws.com/test_models/BeanBag.glb'
            }
        ]
        return { models: models };
    }
}

