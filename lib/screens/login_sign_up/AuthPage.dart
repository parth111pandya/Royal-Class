import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:royal_class_app/screens/categories_page.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //User is loged in
          if (snapshot.hasData) {
            return CategotiesPage();
          }
          //user is NOT logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
