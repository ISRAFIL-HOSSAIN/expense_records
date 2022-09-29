import '../../utils/exports.dart';

class Button extends StatelessWidget {
  final String txt;
  final Function handleButtonClick;
  const Button({Key? key, required this.txt, required this.handleButtonClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(50),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            ),
            backgroundColor: MaterialStateProperty.all(AppColors.kBlueColor),
          ),
          onPressed: () {
            handleButtonClick();
          },
          child: Text(
            txt,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}


// Widget InkwellButtons({
//   required Image image,
// }) {
//   return Expanded(
//     child: Container(
//       width: 170,
//       height: 60,
//       child: image,
//     ),
//   );
// }

// sign up button
// Widget signupContainer({required String st}) {
//   return Container(
//     width: double.infinity,
//     height: 60,
//     decoration: BoxDecoration(
//       color: AppColors.kBlueColor,
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Center(
//       child: customText(
//           txt: st,
//           style: const TextStyle(
//             color: AppColors.kwhiteColor,
//             fontWeight: FontWeight.normal,
//             fontSize: 14,
//           )),
//     ),
//   );
// }




