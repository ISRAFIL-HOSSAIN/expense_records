import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/signup_model.dart';
import '../utils/exports.dart';

class SignupController extends GetxController {
  String email = "";
  String password = "";

  void signUpUser(String email, String password) {
    if (!isEmailValid(email)) {
      Get.snackbar(
        "Sign Up Failed ",
        "Email Id is not valid ",
        icon: const Icon(Icons.error, color: Color.fromARGB(255, 255, 3, 3)),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        borderWidth: 2,
        colorText: Colors.white,
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } else if (!isPassWord(password)) {
      Get.snackbar(
        "Password Not Valid",
        "Password might be 8 to 12 chracter & contain special Cheracter ",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        borderWidth: 2,
        colorText: Colors.white,
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
        icon: const Icon(Icons.password, color: Color.fromARGB(255, 240, 6, 6)),
      );
    } else {
      email = email;
      password = password;

      sendUserDataToServer();
    }
  }

  bool isEmailValid(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  bool isPassWord(String password) {
    bool passwordValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-8])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(password);
    return passwordValid;
  }

  Future<void> sendUserDataToServer() async {
    Map<String, dynamic> dataBody = {
      SignUpModel.USER_EMAIL: email,
      SignUpModel.USER_PASS: password,
    };

    var dataToSend = json.encode(dataBody);
    var response = await http.post(Uri.parse(SignUpModel.signup_api_url),
        body: dataToSend);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['r_msg'] == "success") {
        Get.to(VerificationScreen());
      } else if (responseData['r_msg'] == "failed") {
        Get.snackbar("Sign Up Failed", "Server Problem Occured",
            backgroundColor: Colors.black,
            snackPosition: SnackPosition.BOTTOM,
            borderRadius: 10,
            borderWidth: 2);
      } else if (responseData['r_msg'] == "email already exist") {
        Get.snackbar(
          "Sign Up Failed",
          "You have alreday registered",
          backgroundColor: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          borderWidth: 2,
        );
      }
    } else if (response.statusCode != 200) {
      const Failure(message: "Something is Wrong !");
    } else {
      const CircularProgressIndicator(
        color: Colors.blue,
      );
    }
  }
}
