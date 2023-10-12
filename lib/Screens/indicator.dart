import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MiabeSchoolIndicatorView extends StatelessWidget {
  const MiabeSchoolIndicatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 100,
          child: RiveAnimation.asset(
            'assets/animation/animation.riv',
          ),
        ),
      ),
    );
  }
}
