import '../../utils/exports.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    const CustomText(
                        txt: "Welcome",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomText(
                        txt:
                            "Please Login or sign up to continue using our app",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    // SvgPicture.asset(
                    //   "assets/images/gift.svg",
                    //   height: 100,
                    // ),
                    Image.asset('images/img1.png'),
                    const SizedBox(
                      height: 50,
                    ),

                    Button(
                      txt: "Sign Up",
                      handleButtonClick: () {
                        signUpButtonClickHandler(context);
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: const CustomText(
                        txt: "Don't have an account ? Login",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
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

  signUpButtonClickHandler(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupScreen()));
  }
}
