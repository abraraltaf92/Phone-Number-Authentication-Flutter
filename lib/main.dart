import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hort_demo/checks/wrapper.dart';
import 'package:hort_demo/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hort Demo',
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          accentColor: Colors.brown,
        ),
        home: Wrapper(),
      ),
    );
  }
}
