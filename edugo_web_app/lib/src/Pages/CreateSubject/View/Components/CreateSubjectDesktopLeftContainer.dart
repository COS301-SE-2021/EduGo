import 'package:edugo_web_app/src/Pages/CreateSubject/View/Widgets/CreateSubjectWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectDesktopLeftContainer extends StatefulWidget {
  final Function imageError;
  final Function subjectNotCreatedError;
  final Function subjectCreatedError;
  final GlobalKey<FormState> parentKey;

  const CreateSubjectDesktopLeftContainer(
      {Key key,
      this.imageError,
      this.subjectNotCreatedError,
      this.subjectCreatedError,
      this.parentKey})
      : super(key: key);

  @override
  _CreateSubjectDesktopLeftContainerState createState() =>
      _CreateSubjectDesktopLeftContainerState();
}

class _CreateSubjectDesktopLeftContainerState
    extends State<CreateSubjectDesktopLeftContainer> {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateSubjectController],
      builder: (context, snapshot) {
        var createSubject = snapshot<CreateSubjectModel>();
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
                  padding:
                      EdgeInsets.only(top: 25, bottom: 5, left: 20, right: 20),
                  child: CreateSubjectInputBox(
                    text: "Subject title...",
                    createSubjectKey: widget.parentKey,
                    onSubmit: () async {
                      if ('${createSubject.subjectImage}' == "null")
                        widget.imageError();
                      else
                        await Momentum.controller<CreateSubjectController>(
                                context)
                            .createSubject(context);
                    },
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
                  padding:
                      EdgeInsets.only(top: 25, bottom: 5, left: 20, right: 20),
                  child: CreateSubjectInputBox(
                    text: "Subject grade...",
                    createSubjectKey: widget.parentKey,
                    onSubmit: () {
                      if ('${createSubject.subjectImage}' == "null")
                        widget.imageError();
                      else
                        Momentum.controller<CreateSubjectController>(context)
                            .createSubject(context);
                    },
                    onChanged: (subjectGrade) {
                      Momentum.controller<CreateSubjectController>(context)
                          .setSubjectGrade(subjectGrade);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
