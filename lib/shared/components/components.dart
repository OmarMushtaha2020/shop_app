import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
Widget TextFromFeildPassword(String?text,IconData prefixIcon ,IconData suffixIcon, VoidCallback? funtion,bool ispaswword,TextEditingController controller,TextInputType type,FormFieldValidator<String>? validator)=>TextFormField(
  obscureText:ispaswword ,
  controller: controller,
  validator: validator,
  keyboardType: type,
  decoration: InputDecoration(
    border: OutlineInputBorder(
    ),
    labelText: "$text",
    prefixIcon: Icon(prefixIcon),
    suffixIcon: IconButton(onPressed:funtion ,icon:Icon(suffixIcon)) ),



);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void showTest(String message, Status toast_status) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color_status(toast_status),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum Status { error, succeeded, warning }

Color color_status(Status toast_status) {
  Color color;
  switch (toast_status) {
    case Status.error:
      color = Colors.red;
      break;
    case Status.succeeded:
      color = Colors.green;
      break;
    case Status.warning:
      color = Colors.orangeAccent;
      break;
  }
  return color;
}

Future<void> delay(int millies) async {
  await Future.delayed(Duration(seconds: millies));
}
