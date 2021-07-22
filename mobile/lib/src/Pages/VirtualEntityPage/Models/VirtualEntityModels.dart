class VirtualEntityData {
  final int ve_id;

  VirtualEntityData({required this.ve_id});

  factory VirtualEntityData.fromJson(Map<String, dynamic> json) {
    return VirtualEntityData(ve_id: json["ve_id"]);
  }
}

class VirtualEntity {
  final int id;
  final String title;
  final String description;
  final Model model;
  final Quiz quiz;

  VirtualEntity({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.model,
    required this.quiz
  });

  factory VirtualEntity.fromJson(Map<String, dynamic> json) {
    return VirtualEntity(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      model: Model.fromJson(json["model"]),
      quiz: Quiz.fromJson(json["quiz"])
    );
  }
}

class Model {
  final String name;
  final String description;
  final String file_name;
  final String file_link;
  final String file_type;
  final int file_size;

  Model({
    required this.name,
    required this.description,
    required this.file_name,
    required this.file_link,
    required this.file_type,
    required this.file_size
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      name: json["name"],
      description: json["description"],
      file_name: json["file_name"],
      file_link: json["file_link"],
      file_type: json["file_type"],
      file_size: json["file_size"]
    );
  }
}

class Quiz {
  final int id;
  final String title;
  final String description;
  List<Question>? questions;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    this.questions
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      //questions: json["questions"].map((elem) => Question.fromJson(elem)).toList() as List<Question>
    );
  }
}

enum QuestionType {
  TrueFalse, MultipleChoice, FreeText
}

class Question {
  final int id;
  QuestionType? type;
  final String question;
  String? correctAnswer;
  List<String>? answers;

  Question({
    required this.id,
    this.type,
    required this.question,
    this.correctAnswer,
    this.answers
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json["id"],
      //type: json["type"] as QuestionType,
      question: json["question"],
      correctAnswer: json["correct_answer"],
      answers: json["answers"]
    );
  }
}