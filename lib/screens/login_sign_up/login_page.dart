import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_class_app/screens/categories_page.dart';
import '../../common/DialogMixin.dart';
import '../../custom/custom_elevated_button.dart';
import '../../custom/custom_textfromfild_widget.dart';
import '../../custom/medium_text_widget.dart';
import '../../custom/regular_text_widget.dart';
import '../../custom/square_tile.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/const.dart';
import '../../utils/preference_man.dart';
import 'auth_services.dart';

class LoginPage extends StatefulWidget {
  final Function() onTap;

  LoginPage({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with DialogMixin {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  final signBtnBgColor = Colors.blue;
  final skipBtnBgColor = Colors.blue;

  void signUserIn() async {
    await preferenceMan.init();
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try sign in
    try {
      if (emailController.text == "royalclass@gmail.com" &&
          passwordController.text == "RCB2024") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const CategotiesPage(),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // pop the loading circle
        Navigator.pop(context);
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
      }
    } on FirebaseAuthException catch (error) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (error.code == 'invalid-credential') {
        // show error to user
        showGetXToast(error.code, 'Please enter valid Email ID');
      } else if (error.code == 'wrong-password') {
        // WRONG PASSWORD
        showGetXToast(error.code, 'Please enter valid Password');
      }
    }
  }

  Widget _body(context) {
    return Stack(
      children: [
        Positioned(
            top: 1,
            right: 4,
            child: GestureDetector(
              onTap: () {
                Get.to(const CategotiesPage());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MediumTextWidget(
                    title: "Skip",
                    fontcolor: skipBtnBgColor,
                    fontsize: 18,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: skipBtnBgColor,
                    size: 18,
                  ),
                ],
              ),
            )),
        Form(
          key: _loginKey,
          child: Padding(
            padding: EdgeInsets.all(SCREEN_DEFAULT_PADDING_2W),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://royalclass.group/wp-content/uploads/2022/08/LogoLarge_Small.png',
                ),
                const SizedBox(
                  height: 150,
                ),
                RegularTextWidget(
                  title: "Welcome back you've been missed!",
                  fontcolor: Colors.black,
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
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        onCallPressed: loginBtn,
                        text: 'Sign In',
                        textColor: Colors.black,
                        backgroundColor: Colors.blue,
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
                              onTap: () => _handleGoogleSignIn(),
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
                      title: "Not a member? ",
                      fontsize: 12,
                      fontcolor: Colors.black,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: RegularTextWidget(
                        title: "Register now",
                        fontcolor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _isLoading = false;

  Future<Null> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    AuthServices().signWithGoogle(context);
  }

  loginBtn() {
    if (_loginKey.currentState!.validate()) {
      signUserIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 2),
          child: _body(context),
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
    return const SizedBox(
      height: 4,
    );
  }
}
