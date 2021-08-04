import 'package:edugo_web_app/src/Pages/EduGo.dart';

void main() {
  //* Overiding Error widget
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container();
  };
  //* Wrapping the App in a Momentum instance for state and MVC Management
  runApp(
    Momentum(
      //* controllers used withing the application
      controllers: [
        VirtualEntityController(),
        SubjectController(),
        LessonController()
      ],
      services: [
        MomentumRouter(
          [
            //* All pages that the Router is going to use
            Home(),
            EducatorVirtualEntitiesView(),
            CreateVirtualEntityView(),
            VirtualEntityStoreView(),
            ViewVirtualEntityView(),
            UpdateVirtualEntityView(),
            CreateSubjectView(),
            SubjectsView(),
            CreateLessonView(),
            UpdateSubjectView(),
            CreateSubjectView(),
            LessonsView(),
            UpdateLessonView(),
          ],
        ),
      ],
      //* App Widget to be rendered
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //* Screenutil used for screen sizing
    return ScreenUtilInit(
      //* Initial design screen size
      designSize: Size(1440, 1024),
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
