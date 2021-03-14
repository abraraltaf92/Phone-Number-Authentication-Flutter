import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hort_demo/checks/verifyScreen.dart';
import 'package:hort_demo/constants/colors.dart';
import 'package:hort_demo/constants/spinner.dart';
import 'package:hort_demo/services/auth.dart';
import 'package:hort_demo/ui/home.dart';
import 'package:hort_demo/ui/loginPhone.dart';
import 'package:hort_demo/ui/register.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool showSignUp = false;
  String email = '';
  String password = '';
  String error = '';
  String errorGoogle = '';
  bool _passwordVisible = true;
  bool loading = false;
  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return 'Minimum 6 & Maximum 14 Characters!!!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return showSignUp
        ? Register()
        : loading
            ? Spinner()
            : Scaffold(
                appBar: AppBar(
                  title: Text('Welcome back'),
                  centerTitle: false,
                  actions: [
                    FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            showSignUp = !showSignUp;
                          });
                        },
                        icon: Icon(
                          Icons.person,
                          color: colorPurpleBright,
                        ),
                        label: Text(
                          'SignUp',
                          style: TextStyle(
                              color: colorPurpleBright,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                backgroundColor: colorBlueGrey,
                resizeToAvoidBottomInset: false,
                resizeToAvoidBottomPadding: false,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: 0.8,
                        child: Image.asset(
                          "assets/images/slack.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                end: 50.0),
                                        child: Icon(
                                          Icons.email,
                                          color: colorPrimaryPurple,
                                          size: 25.0,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorBlack),
                                      ),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.grey[900],
                                      ),
                                    ),
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                end: 50.0),
                                        child: Icon(
                                          Icons.lock,
                                          color: colorPrimaryPurple,
                                          size: 25.0,
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(_passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorBlack),
                                      ),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.grey[900],
                                      ),
                                    ),
                                    obscureText: _passwordVisible,
                                    validator: validatePassword,
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic user =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);

                                if (user == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        'could not sign in with these credentials';
                                  });
                                } else {
                                  if (user.emailVerified) {
                                    Get.off(Home());
                                  } else {
                                    Get.to(VerifyScreen());
                                  }
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: colorPurpleBright),
                              child: Center(
                                child: Text(
                                  "Sign in with Email",
                                  style: TextStyle(
                                      color: colorWhite, fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            error,
                            style: TextStyle(fontSize: 14.0, color: colorRed),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Get.to(LoginPhone());
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: colorGoogle),
                              child: Center(
                                child: Text(
                                  "Sign In With Phone Number",
                                  style: TextStyle(
                                    color: colorWhite,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            errorGoogle,
                            style: TextStyle(fontSize: 14.0, color: colorRed),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
  }
}
