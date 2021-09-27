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
  $checkKeys(json, requiredKeys: const ['student_score', 'quiz_total']);
  return Quiz(
    json['quiz_total'] as int,
    json['student_score'] as int,
  );
}

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'student_score': instance.student_score,
      'quiz_total': instance.quiz_total,
    };
