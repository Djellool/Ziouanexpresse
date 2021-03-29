import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Provider/GeneralProvider.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';

class LoginScreen extends StatelessWidget {
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color orange = Color(0xFFF28322);
  final Color blue = Color(0xFF382B8C);
  final Color grey2 = Color(0xFF646464);
  TextEditingController phoneController =
      TextEditingController(text: "0557081936");
  TextEditingController passwordController =
      TextEditingController(text: "password");
  final GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            height: ResponsiveFlutter.of(context).hp(96.5),
            child: Stack(
              children: [
                RotatedBox(
                    quarterTurns: 1,
                    child: Image.asset(
                      "assets/images/image1.jpg",
                      height: ResponsiveFlutter.of(context).wp(100),
                    )),
                Positioned(
                  top: 0,
                  child: Container(
                    width: ResponsiveFlutter.of(context).wp(100),
                    height: ResponsiveFlutter.of(context).hp(100),
                    color: violet.withOpacity(0.8),
                  ),
                ),
                logo(context),
                loginForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo(BuildContext context) {
    return Positioned(
        top: ResponsiveFlutter.of(context).hp(10),
        left: ResponsiveFlutter.of(context).wp(27),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(5)),
            width: ResponsiveFlutter.of(context).wp(46),
            height: ResponsiveFlutter.of(context).hp(13),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Image.asset("assets/images/Logo.png"),
          ),
        ));
  }

  Widget loginForm(BuildContext context) {
    return Positioned(
        top: ResponsiveFlutter.of(context).hp(35),
        bottom: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
            color: white,
          ),
          width: ResponsiveFlutter.of(context).wp(100),
          child: Form(
            key: formKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Connexion",
                      style: TextStyle(
                          color: violet,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveFlutter.of(context).fontSize(5))),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, left: 16.0, right: 16.0, bottom: 16.0),
                    child: Container(
                      child: TextField(
                        controller: phoneController,
                        cursorColor: grey2,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            color: grey2,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.bold),
                        decoration: CommonSyles.textDecoration(context),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, left: 16.0, right: 16.0, bottom: 16.0),
                    child: Container(
                      child: TextField(
                        controller: passwordController,
                        cursorColor: grey2,
                        obscureText: Provider.of<GeneralProvider>(context)
                            .loginVisibility,
                        style: TextStyle(
                            color: grey2,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusColor: blue,
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
                          labelText: "Mot de passe",
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5)),
                          hintStyle: TextStyle(
                            color: grey,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            fontFamily: "Nunito",
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Provider.of<GeneralProvider>(context)
                                      .loginVisibility
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: blue,
                            ),
                            onPressed: () {
                              Provider.of<GeneralProvider>(context,
                                      listen: false)
                                  .changeLoginVisibility();
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: ResponsiveFlutter.of(context).hp(8),
                    width: ResponsiveFlutter.of(context).wp(60),
                    decoration: BoxDecoration(
                      color: violet,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Connexion",
                        style: TextStyle(
                            color: white,
                            fontFamily: "Nunito",
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(3)),
                      ),
                    ),
                  ),
                  FlatButton(
                      onPressed: null,
                      child: Text("Mot de passe oublié !",
                          style: TextStyle(
                              color: violet,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2)))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Vous n'avez pas un compte ?",
                          style: TextStyle(
                              color: grey2,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.2),
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600),
                        ),
                        FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: null,
                            child: Text(
                              "Inscrivez-vous !",
                              style: TextStyle(
                                  color: orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2.2)),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
