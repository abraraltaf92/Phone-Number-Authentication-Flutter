import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hort_demo/constants/colors.dart';
import 'package:hort_demo/ui/otp.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class LoginPhone extends StatefulWidget {
  @override
  _LoginPhoneState createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final _formKey = GlobalKey<FormState>();
  PhoneNumber phoneNumber;
  String error = '';

  String validatePhoneNumber(String value) {
    if (value.trim().isEmpty || value.length < 10) {
      return 'Enter valid Phone Number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBlueGrey,
        appBar: AppBar(
          title: Text('Login Via Phone Number'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: _formKey,
                    child: IntlPhoneField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      validator: validatePhoneNumber,
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("LOGIN VIA OTP"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // print('phoneNumber : ${phoneNumber.completeNumber}');
                          Get.to(() => OTPScreen(phoneNumber.completeNumber));
                          // await _auth.signInWithPhoneNumber(
                          //     phoneNumber.completeNumber, context);
                        } else {
                          setState(() {
                            error = ' Enter valid Number';
                          });
                        }

                        // final phone = _phoneController.text.trim();
                        // print('phone : $phone');
                        // loginUser(phone, context);
                      },
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
