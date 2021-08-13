import 'package:mobile/src/Pages/QuizPage/Controller/QuizPageController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:momentum/momentum.dart';

class QuizPageModel extends MomentumModel<QuizPageController> {
  QuizPageModel(QuizPageController controller,
      {required this.title, required this.description, this.questions})
      : super(controller);
  final String title;
  final String description;
  final List<Question>? questions;

  // TODO: add your final properties here...

  @override
  void update({String? title, String? description, List<Question>? questions}) {
    QuizPageModel(
      controller,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
    ).updateMomentum();
  }
}
/*
export interface Question {
    type: string;
    question: string;
    options: string[];
    correctAnswer: string;
}

export interface Quiz {
    title: string;
    description: string;
    questions: Question[];
}

export interface Model {
    name: string;
    description: string;
    file_link: string;
    file_size: number;
    file_name: string;
    file_type: string;
    preview_img?: string;
}
 */