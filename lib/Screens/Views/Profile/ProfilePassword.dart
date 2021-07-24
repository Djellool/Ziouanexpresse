import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Services/ApiCalls.dart';

class ProfilePassword extends StatefulWidget {
  @override
  _ProfilePasswordState createState() => _ProfilePasswordState();
}

class _ProfilePasswordState extends State<ProfilePassword> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfController = TextEditingController();

  final Color background = Color(0xFFF2F2F2);
  final Color orange = Color(0xFFF28322);
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color grey2 = Color(0xFF646464);
  var provider;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        appBar: CommonSyles.appbar(context, "Mot de passe"),
        backgroundColor: white,
        body: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              child: Container(
                height: ResponsiveFlutter.of(context).hp(89),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    text(context),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 36.0, left: 16.0, right: 16.0, bottom: 16.0),
                      child: Container(
                        child: TextFormField(
                          onEditingComplete: () => node.nextFocus(),
                          textInputAction: TextInputAction.next,
                          validator: (value) => validation(value),
                          controller: passwordController,
                          cursorColor: grey2,
                          obscureText: true,
                          style: TextStyle(
                              letterSpacing: 01,
                              color: grey2,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            focusColor: violet,
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
                                fontSize: ResponsiveFlutter.of(context)
                                    .fontSize(2.5)),
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontFamily: "Nunito",
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 16.0, right: 16.0, bottom: 32.0),
                      child: Container(
                        child: TextFormField(
                          onEditingComplete: () => node.unfocus(),
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.length < 8 || value.isEmpty) {
                              return "Mot de passe moin de 8 caracteres";
                            }
                            if (value != passwordController.text) {
                              return "Mots de passe non identique";
                            }
                            return null;
                          },
                          controller: passwordConfController,
                          cursorColor: grey2,
                          obscureText: true,
                          style: TextStyle(
                              letterSpacing: 01,
                              color: grey2,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            focusColor: violet,
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
                            labelText: "Confirmer le mot de passe",
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                fontSize: ResponsiveFlutter.of(context)
                                    .fontSize(2.5)),
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontFamily: "Nunito",
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
                    button(context, node)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget text(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(80)),
      child: Text(
        "Veuillez entrer un mot de passe\navec plus de 8 caractèrs",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: violet,
            fontFamily: "Nunito",
            fontSize: ResponsiveFlutter.of(context).fontSize(2.8),
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget button(BuildContext context, FocusNode node) {
    return Container(
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
        onPressed: () {
          node.unfocus();
          if (_formKey.currentState.validate()) {
            Map data = {"password": passwordController.text};
            ApiCalls().changerPassword(
                context,
                Provider.of<AuthProvider>(context, listen: false).token,
                Provider.of<AuthProvider>(context, listen: false)
                    .client
                    .idClient,
                data);
          }
        },
        child: Text(
          "Sauvegarder",
          style: TextStyle(
              color: white,
              fontFamily: "Nunito",
              fontSize: ResponsiveFlutter.of(context).fontSize(3)),
        ),
      ),
    );
  }

  String validation(String value) {
    if (value.length == 0 || value.length < 8) {
      return "Veuillez entrer une valeur valide !";
    }
    return null;
  }

  @override
  void dispose() {
    passwordConfController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
