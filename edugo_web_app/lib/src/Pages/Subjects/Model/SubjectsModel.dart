import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Subjects/Model/Data/Subject.dart';
import 'package:edugo_web_app/src/Pages/Subjects/View/Widgets/SubjectsWidgets.dart';

class SubjectsModel extends MomentumModel<SubjectsController> {
  final List<Subject> subjects;
  final List<Widget> subjectCards;

  SubjectsModel(
    SubjectsController controller, {
    this.subjects,
    this.subjectCards,
  }) : super(controller);

// Info: Update list of subjects
  void updateSubjects(List<Subject> subjectsUpdate) {
    update(subjects: subjectsUpdate);
  }

// Info: Update subject cards
  void updateSubjectCards() {
    List<Widget> subjectCardsUpdate = [];
    subjects.forEach(
      (subject) {
        subjectCardsUpdate.add(
          new SubjectsCard(
            title: subject.getSubjectTitle(),
            grade: subject.getSubjectGrade(),
            subjectId: subject.getSubjectId(),
            imageLink: subject.getSubjectImageLink(),
          ),
        );
      },
    );
    if (subjects.isEmpty) {
      subjectCardsUpdate.add(
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150, bottom: 30),
                child: Icon(
                  Icons.auto_stories_outlined,
                  size: 150,
                  color: Color.fromARGB(255, 97, 211, 87),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "No Sub",
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    "jects",
                    style: TextStyle(
                      fontSize: 45,
                      color: Color.fromARGB(255, 97, 211, 87),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
    update(subjectCards: subjectCardsUpdate);
  }

  @override
  void update({
    List<Subject> subjects,
    List<Widget> subjectCards,
  }) {
    SubjectsModel(
      controller,
      subjects: subjects ?? this.subjects,
      subjectCards: subjectCards ?? this.subjectCards,
    ).updateMomentum();
  }
}
