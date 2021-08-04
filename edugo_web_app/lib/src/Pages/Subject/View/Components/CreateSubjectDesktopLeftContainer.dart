import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectDesktopLeftContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [SubjectController],
      builder: (context, snapshot) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Material(
                elevation: 40,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SubjectInputBox(
                    text: "Subject title...",
                    onChanged: (subjectTitle) {
                      Momentum.controller<SubjectController>(context)
                          .setViewBoundSubjectTitle(subjectTitle);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Material(
                elevation: 40,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SubjectInputBox(
                    text: "Subject grade...",
                    onChanged: (subjectGrade) {
                      Momentum.controller<SubjectController>(context)
                          .setViewBoundSubjectGrade(subjectGrade);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              VirtualEntityButton(
                  elevation: 40,
                  child: Text(
                    "Create Subject",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Momentum.controller<SubjectController>(context)
                        .createSubject(context);
                  },
                  width: 450,
                  height: 65),
            ],
          ),
        );
      },
    );
  }
}
