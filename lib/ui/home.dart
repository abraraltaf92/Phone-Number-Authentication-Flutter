import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hort_demo/constants/colors.dart';
import 'package:hort_demo/services/auth.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlueGrey,
      appBar: AppBar(
        title: Text('Hort Demo'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Current User Uid: ' + currentUser.uid),
          Center(
            child: RaisedButton(
              onPressed: () {
                return showDialog(
                    barrierDismissible: false,
                    context: context,
                    child: AlertDialog(
                      title: Text('Do you want to logout from the account?'),
                      content: Stack(
                        children: [
                          Text('We hate to see you leave...'),
                          Lottie.asset(
                            'assets/images/crying.json',
                          )
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            print(' you choose no');
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                        FlatButton(
                          onPressed: () async {
                            print('you choose yes');

                            Navigator.of(context).pop();
                            await _auth.signOut();
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(color: colorRed),
                          ),
                        )
                      ],
                    ));
              },
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
