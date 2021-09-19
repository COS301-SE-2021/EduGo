import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/main.dart';
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:mobile/src/Components/User/Models/UserModel.dart';
import 'package:mobile/src/Components/User/Service/UserService.dart';
import 'package:mobile/src/Pages/LoginPage/View/LoginPage.dart';
import 'package:momentum/momentum.dart';

///Momentum controller for the User Controller
class UserController extends MomentumController<UserModel> {
  UserController({this.mock = false});

  bool mock;

  @override
  UserModel init() {
    return UserModel(this);
  }

  Future<bool> login(
      {required String username, required String password}) async {
    final api = service<UserApiService>();
    model.isLoggedIn = await api.login(
        username: username,
        password: password,
        client: mock == true
            ? httpMock.MockClient(mockApi.loginClient)
            : http.Client());
    return model.isLoggedIn;
  }

  Future<void> logout(context) async {
    final api = service<UserApiService>();
    await api.logout(http.Client());
    model.isLoggedIn = false;
    //clear navigation history and set an initial page
    final router = Momentum.service<MomentumRouter>(context);
    // this will not automatically go to the login page.
    await router.reset<LoginPage>();
    // will be restarted in the login page.
    Momentum.restart(context, momentum());
  }

  Future<User> loadUser() async {
    // model.update(
    //     user: new User(
    //         0, 'username', 'firstName', 'lastName', 'email', UserType.Student),
    //     loadingData: true);
    final api = service<UserApiService>();
    return api
        .getUser(
            client: mock == true
                ? httpMock.MockClient(mockApi.loadUserClient)
                : http.Client())
        .then((value) {
      model.update(user: value, loadingData: false);
      print('updated');
      return value;
    });
  }

  Future<bool> verify({required String email, required String code}) {
    final api = service<UserApiService>();
    return api.verify(
        email: email,
        code: code,
        client:
            mock == true ? httpMock.MockClient(mockApi.verify) : http.Client());
  }

  Future<bool> register({
    required String username,
    required String password,
    required String email,
    required String firstName,
    required String lastName,
    // required String organisation_id,
    // required String type
  }) {
    final api = service<UserApiService>();
    return api.register(
        username: username,
        password: password,
        email: email,
        firstName: firstName,
        lastName: lastName,
        // organisation_id: organisation_id,
        // type: type,
        client: mock == true
            ? httpMock.MockClient(mockApi.register)
            : http.Client());
  }
}
