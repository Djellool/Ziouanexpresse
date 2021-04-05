import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class CommonSyles {
  static textDecoration(BuildContext context, String label, Icon icon) {
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

  static containerDecoration(BuildContext context) {
    final Color violet = Color(0xFF382B8C);
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
      boxShadow: [
        BoxShadow(blurRadius: 10, color: Colors.grey),
      ],
    );
  }

  static pinDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
      border: Border.all(
        color: Color(0xFF382B8C),
      ),
    );
  }

  static rows(String champ, IconData icon, BuildContext context, Color color) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: ResponsiveFlutter.of(context).scale(35),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      Text(
        champ,
        style: TextStyle(
            color: color,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveFlutter.of(context).fontSize(2.8)),
      ),
    ]);
  }

  static appbar(context, String title) {
    Color violet = Color(0xFF382B8C);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      shadowColor: null,
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: violet),
          onPressed: () => Navigator.pop(context)),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Nunito",
          fontSize: ResponsiveFlutter.of(context).fontSize(4),
          fontWeight: FontWeight.bold,
          color: Color(0xFF382B8C),
        ),
      ),
    );
  }
}
