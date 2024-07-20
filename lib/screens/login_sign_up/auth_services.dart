import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';
import '../../utils/const.dart';
import '../categories_page.dart';

class AuthServices {
  //Google Sgin in
  signWithGoogle(context) async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtiin auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create new credential for user

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    // finally,lets sign in
    var tempCred = await FirebaseAuth.instance.signInWithCredential(credential);
    uidList.add(tempCred.user!.uid);
    preferenceMan.saveUserLogin(true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const CategotiesPage(),
      ),
      (Route<dynamic> route) => false,
    );
    return tempCred;
  }
}
