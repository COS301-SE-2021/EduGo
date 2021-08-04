import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonDesktopBottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [LessonController, SubjectController],
      builder: (context, snapshot) {
        Momentum.controller<LessonController>(context)
            .setViewBoundLessonSubjectId(
                snapshot<SubjectModel>().currentSubject.getSubjectId());
        return Row(
          children: <Widget>[
            Container(
              height: 400,
              padding: EdgeInsets.only(left: 70),
              width: ScreenUtil().setWidth(450),
              child: SfDateRangePicker(
                selectionColor: Color.fromARGB(255, 97, 211, 87),
                todayHighlightColor: Color.fromARGB(255, 97, 211, 87),
                enablePastDates: false,
                yearCellStyle: DateRangePickerYearCellStyle(
                  todayTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  todayTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onSelectionChanged:
                    Momentum.controller<LessonController>(context)
                        .setViewBoundLessonDate,
                selectionMode: DateRangePickerSelectionMode.single,
              ),
            ),
            Spacer(),
            Container(
              width: ScreenUtil().setWidth(450),
              padding: EdgeInsets.only(right: 70, top: 100),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TimeRange(
                        fromTitle: Text(
                          'Lesson Start Time',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        toTitle: Text(
                          'Lesson End Time',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                        activeTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 97, 211, 87)),
                        borderColor: Colors.black,
                        backgroundColor: Colors.transparent,
                        activeBackgroundColor: Colors.transparent,
                        firstTime: TimeOfDay(hour: 14, minute: 30),
                        lastTime: TimeOfDay(hour: 20, minute: 00),
                        timeStep: 10,
                        timeBlock: 30,
                        onRangeCompleted: (range) {}),
                  ),
                  SizedBox(height: 40),
                  LessonButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.storefront_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Add Virtual Entity",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    width: 250,
                    height: 60,
                  ),
                  SizedBox(height: 20),
                  LessonButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.photo_camera_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Add Image",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    width: 250,
                    height: 60,
                  ),
                  SizedBox(height: 40),
                  LessonButton(
                      elevation: 40,
                      child: Text(
                        "Create Lesson",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                      width: ScreenUtil().setWidth(500),
                      height: 65),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

  // LessonButton(
  //                 onPressed: () {},
  //                 child: Row(
  //                   children: <Widget>[
  //                     Icon(
  //                       Icons.add,
  //                       color: Colors.white,
  //                     ),
  //                     SizedBox(width: 20),
  //                     Text(
  //                       "Add Virtual Entity",
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 width: 250,
  //                 height: 60,
  //               ),