import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hort_demo/constants/colors.dart';
import 'package:hort_demo/services/auth.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService();
  @override
  void initState() {
    currentUser.sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBlueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitCubeGrid(
            color: colorPurpleBright,
            size: 50.0,
          ),
          AlertDialog(
            title: Center(child: Text('Email Verification')),
            content: Container(
              height: 90,
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Verification link has been sent to \n\n',
                        style: TextStyle(color: colorBlack)),
                    TextSpan(
                        text: '${currentUser.email}',
                        style: TextStyle(
                            color: colorRed,
                            decoration: TextDecoration.underline))
                  ])),
                  SizedBox(
                    height: 22,
                  ),
                ],
              )),
            ),
            actions: [
              FlatButton(
                child: Text(
                  "Already Verified, Sign In!",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              FlatButton(
                child: Text(
                  "Wrong Email Given",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  await _auth.deleteUserAccount();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Send Link Again"),
                onPressed: () async =>
                    await currentUser.sendEmailVerification(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
