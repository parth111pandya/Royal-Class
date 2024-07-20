import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../common/DialogMixin.dart';
import '../../custom/custom_elevated_button.dart';
import '../../custom/custom_textfromfild_widget.dart';
import '../../custom/regular_text_widget.dart';
import '../../custom/square_tile.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/const.dart';
import '../categories_page.dart';
import 'auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;

  RegisterPage({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with DialogMixin {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final signBtnBgColor = AppColors.Cerulean;

  void signUserUp() async {
    await preferenceMan.init();

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try sign up
    try {
      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: confirmPasswordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
      uidList.add(credential.user!.uid);
      preferenceMan.saveUserLogin(true);
      uidList.contains(credential.user!.uid)
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CategotiesPage(),
              ),
              (Route<dynamic> route) => false,
            )
          : showGetXToast(
              'Alert',
              'Please enter valid Email ID',
            );
    } on FirebaseAuthException catch (error) {
      print(error.code);
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (error.code == 'user-not-found') {
        // show error to user
        showGetXToast(error.code, 'Please enter valid Email ID');
      } else if (error.code == 'email-already-in-use') {
        showGetXToast(error.code, 'ERROR_EMAIL_ALREADY_IN_USE');
      }
      // WRONG PASSWORD
      else if (error.code == 'wrong-password') {
        showGetXToast(error.code, 'Please enter valid Password');
      }
    }
  }

  Widget _body() {
    return Form(
      key: _loginKey,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginSizeBox(),
            // let's create an account for you!
            RegularTextWidget(
              title: "let's create an account for you!",
            ),
            const LoginSizeBox(),
            CustomTextFromField(
              controller: emailController,
              onChanged: (value) {
                setState(() {});
              },
              hintText: "example@gmail.com",
              validator: (value) {
                if (!GetUtils.isEmail(value!)) {
                  return 'Enter valid Email ID';
                } else {
                  return null;
                }
              },
            ),
            const LoginSizeBox(),
            CustomTextFromField(
              controller: passwordController,
              onChanged: (value) {
                setState(() {});
              },
              IconType: 'pass',
              isPassword: true,
              hintText: "Password",
              validator: (value) {
                if (!GetUtils.isLengthGreaterOrEqual(value!, 6)) {
                  return 'Enter Password more then 6 charactes';
                } else {
                  return null;
                }
              },
            ),
            const LoginSizeBox(),
            CustomTextFromField(
              controller: confirmPasswordController,
              onChanged: (value) {
                setState(() {});
              },
              IconType: 'pass',
              isPassword: true,
              hintText: "Confirm Password",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Confirm Password';
                } else if (value != passwordController.text) {
                  return 'Enter Confirm Password is not same as Password';
                } else {
                  return null;
                }
              },
            ),
            const LoginSizeBox(),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onCallPressed: signUp,
                    text: 'Sign Up',
                    textColor: Colors.black,
                    backgroundColor: AppColors.Cerulean,
                  ),
                ),
              ],
            ),
            const LoginSizeBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            const LoginSizeBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(_isLoading ? 20.0 : 0.0),
                  width: 75,
                  height: 75,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : SquareTile(
                          onTap: () => _handleGoogleSignIn(context),
                          imagePath: 'assets/images/google.png',
                        ),
                )
              ],
            ),
            const LoginSizeBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RegularTextWidget(
                  title: "Already have an account? ",
                  fontsize: 15,
                  fontcolor: Colors.black,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: RegularTextWidget(
                    title: "Login now",
                    fontcolor: AppColors.Cerulean,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _isLoading = false;

  Future<Null> _handleGoogleSignIn(context) async {
    setState(() {
      _isLoading = true;
    });
    AuthServices().signWithGoogle(context);
  }

  signUp() {
    if (_loginKey.currentState!.validate()) {
      signUserUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: _body(),
        ),
      ),
    );
  }
}

class LoginSizeBox extends StatefulWidget {
  const LoginSizeBox({Key? key}) : super(key: key);

  @override
  State<LoginSizeBox> createState() => _LoginSizeBoxState();
}

class _LoginSizeBoxState extends State<LoginSizeBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
    );
  }
}
