import 'package:flutter/material.dart';

// import '../../utils/appColors.dart';

class CustomText extends StatelessWidget {
  final String txt;
  final TextStyle style;

  const CustomText({
    Key? key,
    required this.txt,
    required this.style,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: style,
    );
  }
}
