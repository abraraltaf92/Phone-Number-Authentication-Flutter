import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hort_demo/checks/verifyScreen.dart';
import 'package:hort_demo/constants/colors.dart';
import 'package:hort_demo/constants/spinner.dart';
import 'package:hort_demo/services/auth.dart';
import 'package:hort_demo/ui/home.dart';
import 'package:hort_demo/ui/loginPhone.dart';
import 'package:hort_demo/ui/signIn.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');

  bool isChecked = false;
  bool showSignIn = false; // toggle for signUp/SignIn
  bool _passwordVisible = true;
  String email = '';
  String password = '';
  String rePassword = '';
  String errorCheckbox = '';
  String errorSignUp = '';
  String errorPhone = '';
  bool loading = false;

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Enter Valid Email Id!!!';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return 'Minimum 6 & Maximum 14 Characters!!!';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return 'Password Mismatch!!!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn()
        : loading
            ? Spinner()
            : Scaffold(
                backgroundColor: colorBlueGrey,
                resizeToAvoidBottomInset: false,
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                  title: Text('Welcome newbie'),
                  centerTitle: false,
                  actions: [
                    FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            showSignIn = !showSignIn;
                          });
                        },
                        icon: Icon(
                          Icons.person,
                          color: colorPurpleBright,
                        ),
                        label: Text(
                          'SignIn',
                          style: TextStyle(
                              color: colorPurpleBright,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
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
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, right: 30, left: 30, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              controller: _emailIdController,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 50.0),
                                  child: Icon(
                                    Icons.email,
                                    color: colorPrimaryPurple,
                                    size: 25.0,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colorBlack),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey[900],
                                ),
                              ),
                              validator: validateEmail,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 50.0),
                                  child: Icon(
                                    Icons.lock,
                                    color: colorPrimaryPurple,
                                    size: 25.0,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colorBlack),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey[900],
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: validatePassword,
                              obscureText: _passwordVisible,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 50.0),
                                  child: Icon(
                                    Icons.lock,
                                    color: colorPrimaryPurple,
                                    size: 25.0,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colorBlack),
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey[900],
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (val) => val != password
                                  ? "Password doesn't match"
                                  : null,
                              obscureText: _passwordVisible,
                              onChanged: (val) {
                                setState(() {
                                  rePassword = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton.icon(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                                icon: isChecked
                                    ? Icon(Icons.check_box)
                                    : Icon(Icons.check_box_outline_blank),
                                label: Text(
                                  'By Signing Up, I agree to  \n t&c blah blah blah.',
                                  style: TextStyle(
                                      color: colorBlack, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            errorCheckbox,
                            style: TextStyle(fontSize: 14.0, color: colorRed),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState.validate() && isChecked) {
                          setState(() {
                            loading = true;
                            errorCheckbox = " ";
                          });
                          dynamic user = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (user != null) {
                            if (user.emailVerified) {
                              setState(() {
                                loading = false;
                              });
                              Get.offAll(Home());
                            } else {
                              setState(() {
                                loading = false;
                              });
                              Get.to(() => VerifyScreen());
                            }
                          }
                          if (user == null) {
                            setState(() {
                              loading = false;
                              errorSignUp =
                                  'Could not sign up with these credentials';
                            });
                          }
                        } else if (!isChecked) {
                          setState(() {
                            loading = false;
                            errorCheckbox =
                                'Please indicate that you accept the Terms and Conditions';
                          });
                        } else {
                          setState(() {
                            loading = false;
                          });
                          print('validation failed');
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
                            "Sign Up with Email",
                            style: TextStyle(color: colorWhite, fontSize: 17.0),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      errorSignUp,
                      style: TextStyle(fontSize: 14.0, color: colorRed),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.to(() => LoginPhone());
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: colorGoogle),
                        child: Center(
                          child: Text(
                            "Sign Up With Phone Number",
                            style: TextStyle(
                              color: colorWhite,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      errorPhone,
                      style: TextStyle(fontSize: 14.0, color: Colors.red),
                    ),
                  ],
                ),
              );
  }
}
