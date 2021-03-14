import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hort_demo/constants/colors.dart';

class Spinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBlueGrey,
      child: Center(
        child: SpinKitCircle(
          color: colorPurpleBright,
          size: 100.0,
        ),
      ),
    );
  }
}
