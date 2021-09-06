// import 'package:flutter/material.dart';
// import 'package:mobile/Constants.dart';
// import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
// import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
// import 'package:mobile/src/Components/QuestionCardWidget.dart';
// import 'package:momentum/momentum.dart';

// //import 'package:flutter_svg/svg.dart';
// //import 'progress_bar.dart';
// //import 'package:get/get.dart';

// class Body extends StatelessWidget {
//   const Body({
//     required Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MomentumBuilder(
//       controllers: [QuizController],
//       builder: (context, snapshot) {
//         //Stores a snapshot of the current subject
//         //list in the SubjectModel page
//         final quiz = snapshot<QuizModel>();

//         return Stack(
//           children: [
//             //SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
//             SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//                     //child: ProgressBar(),
//                   ),
//                   SizedBox(height: kDefaultPadding),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//                     child: Obx(
//                       () => Text.rich(
//                         TextSpan(
//                           text:
//                               "Question ${_questionController.questionNumber.value}",
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline4
//                               .copyWith(color: kSecondaryColor),
//                           children: [
//                             TextSpan(
//                               text: "/${_questionController.questions.length}",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headline5
//                                   .copyWith(color: kSecondaryColor),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Divider(thickness: 1.5),
//                   SizedBox(height: kDefaultPadding),
//                   Expanded(
//                     child: PageView.builder(
//                       // Block swipe to next qn
//                       physics: NeverScrollableScrollPhysics(),
//                       controller: _questionController.pageController,
//                       onPageChanged: _questionController.updateTheQnNum,
//                       itemCount: _questionController.questions.length,
//                       itemBuilder: (context, index) => QuestionCard(
//                           question: _questionController.questions[index]),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );

//     // }
//   }
// }
