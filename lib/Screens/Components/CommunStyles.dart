import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class CommonSyles {
  static textDecoration(BuildContext context) {
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
      labelText: "Numéro de téléphone",
      labelStyle: TextStyle(
          color: Colors.black,
          fontFamily: "Nunito",
          fontWeight: FontWeight.bold,
          fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
    );
  }
}
