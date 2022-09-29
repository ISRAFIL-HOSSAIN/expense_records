import 'package:expense_record/view/auth/forgot_password_screen.dart';

import '../../utils/exports.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();

  final _formKey = GlobalKey<FormState>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   emailController = TextEditingController();
  //   passwordController = TextEditingController();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onCLose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  // }

  // String? validateEmail(String value) {
  //   if (!GetUtils.isEmail(value)) {
  //     return "Provide valid Email";
  //   }
  //   return null;
  // }

  // String? validatePassword(String value) {
  //   if (value.length <= 6) {
  //     return "Password must be of 6 chracters ";
  //   }
  //   return null;
  // }

  // void checkLogin() {
  //   final isValid = loginFormKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   loginFormKey.currentState!.save();
  // }
}

class _SigninScreenState extends State<SigninScreen> {
  String emailError = "Email Field can not be empty";
  String passwordError = "Password Field Can not be Empty";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Icon icon;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.blueAccent),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    children: [
                      const CustomText(
                        txt: "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CustomText(
                        txt: "Please sign-in to enter app",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 239, 231, 246),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'images/illustration-1.png',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        txt: "Email",
                        txt2: "Email",
                        controller: emailController,
                        error: emailError,
                        icon: Icon(Icons.email),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordField(
                        txt: "Password",
                        txt2: "Password",
                        controller: passwordController,
                        error: emailError,
                        icon: const Icon(Icons.lock),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child:  Button(txt: "SignIn", handleButtonClick: (){
                          
                        },),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Dont have account ? "),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "SignUp",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kBlueColor,
                              ),
                            ),
                          ],
                        ),

                        // child: const CustomText(
                        //   txt: "You don't have an account ? SignUp",
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 14,
                        //   ),
                        // ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
