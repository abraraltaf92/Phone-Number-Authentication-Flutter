import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hort_demo/checks/authenticate.dart';
import 'package:hort_demo/checks/verifyScreen.dart';
import 'package:hort_demo/ui/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      if (user.emailVerified || user.phoneNumber.isNotEmpty) {
        return Home();
      }
      return VerifyScreen();
    }
  }
}
