/**
 * This is the quizz controller. It handles the api calls to get the quizzes
 * for a lesson.The endpoint is getSubjectsByUser which return a list 
 * of subjects. That list is converted from a string to a json object. 
*/

import 'package:mobile/src/Pages/QuizPage/Model/AnswerModel.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                          Quizz controller
 *------------------------------------------------------------------------------
 */

//QuizController constructor with a default value of mock set to false
class AnswerController extends MomentumController<AnswerModel> {
  AnswerController();

  //Instantiale the quiz model
  @override
  AnswerModel init() {
    return AnswerModel(this, checkArray: []);
  }

  void updateCheckArray(List<bool> array, int index) {
    for (int i = 0; i < array.length; i++) {
      array[i] = false;
    }

    array[index] = true;
    model.update(checkArray: array);
  }

  List<bool> getCheckArray() {
    return getCheckArray();
  }

  @override
  Future<void> bootstrapAsync() async {
    model.init();
  }

  void setCheckArray(List<bool> array, int length) {
    for (int i = 0; i < length; i++) {
      array[i] = false;
    }
    model.update(checkArray: array);
  }
}
