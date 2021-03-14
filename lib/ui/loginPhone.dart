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
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: FlatButton(
                      child: Text("Get Your Code"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Get.to(() => OTPScreen(phoneNumber.completeNumber));
                        } else {
                          setState(() {
                            error = ' Enter valid Number';
                          });
                        }
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
