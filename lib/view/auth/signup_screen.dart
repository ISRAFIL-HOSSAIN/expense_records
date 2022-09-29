import 'package:expense_record/utils/exports.dart';
import 'package:get/get.dart';

import '../../controller/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupController signUpController = Get.put(SignupController());
  final _globalKey = GlobalKey<FormState>();

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
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    const CustomText(
                      txt: "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const CustomText(
                      txt: "Please sign up to enter app",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'images/illustration-2.png',
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
                      icon: const Icon(Icons.email),
                      onUseridValueChange: (value) {
                        print(value);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PasswordField(
                      txt: "Password",
                      txt2: "Password",
                      controller: passwordController,
                      error: passwordError,
                      icon: const Icon(Icons.lock),
                      onUseridValueChange: (value) {
                        print(value);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                        txt: "Sign Up",
                        handleButtonClick: () {
                          signup();
                        }),

                    // onTap: () {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => const VerificationScreen(),
                    //     ),
                    //   );
                    // },

                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Already have an account  ? "),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "SignIn",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kBlueColor,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SigninScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signup() {
    final isValid = _globalKey.currentState!.validate();
    if (isValid) {
      // print(emailController.text);
      // print(passwordController.text);

      signUpController.signUpUser(
        emailController.text,
        passwordController.text,
      );
    } else {
      return;
    }
  }
}
