import '../../utils/exports.dart';

class CustomTextField extends StatelessWidget {
  final String txt;
  final String txt2;
  TextEditingController controller;
  final String error;
  Icon icon;
  final Function onUseridValueChange;
  CustomTextField({
    Key? key,
    required this.txt,
    required this.txt2,
    required this.controller,
    required this.error,
    required this.icon,
    required this.onUseridValueChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return error;
        } else {
          return null;
        }
      },
      onChanged: (value) {
        onUseridValueChange(value);
      },
      decoration: InputDecoration(
          labelText: txt,
          hintText: txt2,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 17,
          ),
          prefixIcon: icon,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            width: 5,
            color: AppColors.kDarkblack,
            style: BorderStyle.solid,
          ))),
      autofocus: true,
      keyboardType: TextInputType.multiline,
    );
  }
}
