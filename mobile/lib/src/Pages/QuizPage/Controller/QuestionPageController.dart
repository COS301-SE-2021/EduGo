class QuestionController extends MomentumController<QuestionPageModel> {
  QuestionController({this.mock = false});
  bool mock;

  QuestionPageModel init() {
    return QuestionPageModel(this, quizes: []);
  }

  @override
  Future<void> bootstrapAsync() {
    return getQuestionesByLesson(1,
            client: mock
                ? httpMock.MockClient(mockApi.getQuestionesByLesson)
                : http.Client())
        .then((value) {
      print('Value');
      print(value);
      model.update();
    });
  }
}
