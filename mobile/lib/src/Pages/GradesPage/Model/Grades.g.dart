// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Grades.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'id',
    'subjectName',
    'gradeAchieved',
    'lessonGrades'
  ]);
  return Subject(
    json['id'] as int,
    (json['lessonGrades'] as List<dynamic>)
        .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['gradeAchieved'] as num).toDouble(),
    json['subjectName'] as String,
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'subjectName': instance.subjectName,
      'gradeAchieved': instance.gradeAchieved,
      'lessonGrades': instance.lessonGrades,
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'gradeAchieved', 'lessonName', 'quizGrades']);
  return Lesson(
    json['id'] as int,
    (json['gradeAchieved'] as num).toDouble(),
    (json['quizGrades'] as List<dynamic>)
        .map((e) => Quiz.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['lessonName'] as String,
  );
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'gradeAchieved': instance.gradeAchieved,
      'lessonName': instance.lessonName,
      'quizGrades': instance.quizGrades,
    };

Quiz _$QuizFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'name',
    'student_score',
    'quiz_total',
    'quiz_answers'
  ]);
  return Quiz(
    json['name'] as String,
    json['quiz_total'] as int,
    json['student_score'] as int,
    (json['quiz_answers'] as List<dynamic>)
        .map((e) => QuizAnswers.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'name': instance.name,
      'student_score': instance.student_score,
      'quiz_total': instance.quiz_total,
      'quiz_answers': instance.quiz_answers,
    };

QuizAnswers _$QuizAnswersFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'answer', 'correctAnswer', 'question']);
  return QuizAnswers(
    json['id'] as int,
    json['answer'] as String,
    json['correctAnswer'] as String,
    Question.fromJson(json['question'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QuizAnswersToJson(QuizAnswers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
      'correctAnswer': instance.correctAnswer,
      'question': instance.question,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'type',
    'question',
    'id',
    'options',
    'correctAnswer'
  ]);
  return Question(
    json['type'] as String,
    json['question'] as String,
    json['id'] as int,
    json['imageLink'] as String,
    (json['options'] as List<dynamic>).map((e) => e as String).toList(),
    json['correctAnswer'] as String,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'type': instance.type,
      'question': instance.question,
      'imageLink': instance.imageLink,
      'id': instance.id,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
    };
