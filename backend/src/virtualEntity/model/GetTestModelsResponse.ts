export interface TestModel {
    name: string;
    link: string;
}

export interface GetTestModelsResponse {
    models: TestModel[];
}