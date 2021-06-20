import 'package:edugo_web_app/ui/Views/SignIn/SignInPageForm.dart';
import 'package:flutter/material.dart';

class SignInPageContent extends StatelessWidget {
  const SignInPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: Card(
          child: SignInPageForm(),
        ),
      ),
    );
  }
}
