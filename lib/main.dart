import 'package:expense_record/view/page/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './utils/exports.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Record',
        theme: ThemeData(
          primaryColor: AppColors.backColor,
        ),
        home: const IntroScreen());
  }
}
