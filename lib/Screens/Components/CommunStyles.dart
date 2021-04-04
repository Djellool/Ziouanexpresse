import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class CommonSyles {
  static textDecoration(BuildContext context, String label, Icon icon) {
    Color blue = Color(0xFF382B8C);
    return InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0)),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Nunito",
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
        suffixIcon: icon);
  }
}
