
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:support_me/Authenticate/LoginScree.dart';
import 'package:support_me/Screens/HomeScreen.dart';


//what Authenticate means ?
/*يعني توثيث لل action الي هيحصل عند استدعاء الدالة ده */


class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
