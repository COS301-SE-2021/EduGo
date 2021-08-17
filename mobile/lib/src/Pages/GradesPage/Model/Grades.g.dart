// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Grades.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'title', 'mark', 'lessons']);
  return Subject(
    json['id'] as int,
    (json['lessons'] as List<dynamic>)
        .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['mark'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'mark': instance.mark,
      'lessons': instance.lessons,
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'mark', 'title', 'quizzes']);
  return Lesson(
    json['id'] as int,
    json['mark'] as int,
    (json['quizzes'] as List<dynamic>)
        .map((e) => Quiz.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['title'] as String,
  );
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'mark': instance.mark,
      'title': instance.title,
      'quizzes': instance.quizzes,
    };

Quiz _$QuizFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'id',
    'title',
    'studentMark',
    'quizTotal',
    'studentAnswers',
    'correctAnswers'
  ]);
  return Quiz(
    json['id'] as int,
    json['quizTotal'] as int,
    json['studentMark'] as int,
    json['title'] as String,
    (json['correctAnswers'] as List<dynamic>).map((e) => e as String).toList(),
    (json['studentAnswers'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'studentMark': instance.studentMark,
      'quizTotal': instance.quizTotal,
      'studentAnswers': instance.studentAnswers,
      'correctAnswers': instance.correctAnswers,
    };