import 'package:edugo_web_app/src/Pages/CreateSubject/View/Widgets/CreateSubjectWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectDesktopLeftContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateSubjectController],
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
                  child: CreateSubjectInputBox(
                    text: "Subject title...",
                    onChanged: (subjectTitle) {
                      Momentum.controller<CreateSubjectController>(context)
                          .setSubjectTitle(subjectTitle);
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
                  child: CreateSubjectInputBox(
                    text: "Subject grade...",
                    onChanged: (subjectGrade) {
                      Momentum.controller<CreateSubjectController>(context)
                          .setSubjectGrade(subjectGrade);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CreateSubjectButton(
                  elevation: 40,
                  child: Text(
                    "Create Subject",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Momentum.controller<CreateSubjectController>(context)
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
