import 'package:edugo_web_app/src/Pages/EduGo.dart';

void main() {
  //* Overiding Error widget
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container();
  };
  //* Wrapping the App in a Momentum instance for state and MVC Management
  runApp(momentum());
}

Momentum momentum() {
  return Momentum(
    //* controllers used withing the application
    controllers: [
      AdminController(),
      CreateLessonController(),
      CreateOrganisationController(),
      CreateSubjectController(),
      CreateVirtualEntityController(),
      InviteEducatorsController(),
      InviteStudentsController(),
      CanvasController(),
      LessonsController(),
      SubjectsController(),
      QuizBuilderController(),
      VirtualEntityStoreController(),
      ViewVirtualEntityController(),
      LogInController(),
      ViewLessonController(),
      StudentsGradesController()
    ],
    services: [
      MomentumRouter(
        [
          //* All pages that the Router is going to use
          Home(),
          AdminView(),
          InviteEducatorsView(),
          CanvasView(),
          ViewLessonView(),
          VirtualEntityStoreView(),
          ViewVirtualEntityView(),
          InviteStudentsView(),
          CreateVirtualEntityView(),
          CreateSubjectView(),
          SubjectsView(), AddVirtualEntityView(),
          CreateLessonView(), AddEntityStore(),
          LessonsView(),
          LogInView(),
          CreateOrganisationView(),
          StudentsGradesView()
        ],
      ),
    ],
    //* App Widget to be rendered
    child: MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //* Screenutil used for screen sizing
    return ScreenUtilInit(
      //* Initial design screen size
      designSize: Size(1920, 1080),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EduGo',
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 97, 211, 87),
            primarySwatch: Colors.blue,
            fontFamily: "Montserrat"),
        home: MomentumRouter.getActivePage(context),
      ),
    );
  }
}
