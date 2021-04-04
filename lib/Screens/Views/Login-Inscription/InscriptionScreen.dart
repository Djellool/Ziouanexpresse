import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Provider/GeneralProvider.dart';
import 'package:ziouanexpress/Provider/InscriptionProvider.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Views/Login-Inscription/ConfirmSms.dart';

class InscriptionScreen extends StatefulWidget {
  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color orange = Color(0xFFF28322);
  final Color grey2 = Color(0xFF646464);

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: "Yessad");
  TextEditingController prenomController = TextEditingController(text: "Samy");
  TextEditingController eMailController =
      TextEditingController(text: "test@test.com");
  TextEditingController phoneController =
      TextEditingController(text: "0557081936");
  TextEditingController passwordController =
      TextEditingController(text: "password");
  TextEditingController passwordConfirmationController =
      TextEditingController(text: "password");

  void changeInfoInscrit(BuildContext context, String nom, String prenom,
      String eMail, String phoneNumber, String password, String passwordConf) {
    Provider.of<InscriptionProvider>(context, listen: false).changeNom(nom);
    Provider.of<InscriptionProvider>(context, listen: false)
        .changePrenom(prenom);
    Provider.of<InscriptionProvider>(context, listen: false).changeEMail(eMail);
    Provider.of<InscriptionProvider>(context, listen: false)
        .changePhoneNumber(phoneNumber);
    Provider.of<InscriptionProvider>(context, listen: false)
        .changePassword(password);
    Provider.of<InscriptionProvider>(context, listen: false)
        .changePasswordConf(passwordConf);
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              height: ResponsiveFlutter.of(context).hp(96.5),
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/image1.jpg",
                    width: ResponsiveFlutter.of(context).wp(100),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: ResponsiveFlutter.of(context).wp(100),
                      height: ResponsiveFlutter.of(context).hp(100),
                      color: violet.withOpacity(0.8),
                    ),
                  ),
                  Positioned(
                    top: ResponsiveFlutter.of(context).hp(5),
                    child: Container(
                      width: ResponsiveFlutter.of(context).wp(100),
                      padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveFlutter.of(context).scale(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: white,
                                size: ResponsiveFlutter.of(context).fontSize(5),
                              ),
                              onPressed: () => Navigator.pop(context)),
                          Text(
                            "Inscription",
                            style: TextStyle(
                                color: white,
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(5),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nunito"),
                          ),
                          SizedBox(
                            child: IconButton(
                              onPressed: null,
                              icon: Visibility(
                                visible: false,
                                child: Icon(
                                  Icons.arrow_back,
                                  size:
                                      ResponsiveFlutter.of(context).fontSize(5),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  loginForm(context, node)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm(BuildContext context, FocusNode node) {
    return Positioned(
        top: ResponsiveFlutter.of(context).hp(16),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  nameField(context, node),
                  prenomField(context, node),
                  eMailField(context, node),
                  phoneField(context, node),
                  passwordField(context, node),
                  passwordConfField(context, node),
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
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          changeInfoInscrit(
                              context,
                              nameController.text,
                              prenomController.text,
                              eMailController.text,
                              phoneController.text,
                              passwordController.text,
                              passwordConfirmationController.text);
                          Provider.of<GeneralProvider>(context, listen: false)
                              .changeRenvoyerIns(false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmSmsScreen()));
                        }
                      },
                      child: Text(
                        "Inscription",
                        style: TextStyle(
                            color: white,
                            fontFamily: "Nunito",
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget nameField(BuildContext context, FocusNode node) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.nextFocus(),
          textInputAction: TextInputAction.next,
          controller: nameController,
          cursorColor: grey2,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
          decoration: CommonSyles.textDecoration(context, "Nom"),
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
    );
  }

  Widget prenomField(BuildContext context, FocusNode node) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.nextFocus(),
          textInputAction: TextInputAction.next,
          controller: prenomController,
          cursorColor: grey2,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
          decoration: CommonSyles.textDecoration(context, "Prénom"),
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
    );
  }

  Widget eMailField(BuildContext context, FocusNode node) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.nextFocus(),
          textInputAction: TextInputAction.next,
          controller: eMailController,
          cursorColor: grey2,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
          decoration: CommonSyles.textDecoration(context, "Adresse mail"),
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
    );
  }

  Widget phoneField(BuildContext context, FocusNode node) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.nextFocus(),
          textInputAction: TextInputAction.next,
          controller: phoneController,
          cursorColor: grey2,
          keyboardType: TextInputType.phone,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
          decoration:
              CommonSyles.textDecoration(context, "Numéro de téléphone"),
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
    );
  }

  Widget passwordField(BuildContext context, FocusNode node) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.nextFocus(),
          textInputAction: TextInputAction.next,
          controller: passwordController,
          cursorColor: grey2,
          obscureText: true,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
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
                fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
            hintStyle: TextStyle(
              color: grey,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
            ),
            suffixIcon: null,
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
    );
  }

  Widget passwordConfField(BuildContext context, FocusNode node) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 18.0, left: 16.0, right: 16.0, bottom: 16.0),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.unfocus(),
          textInputAction: TextInputAction.done,
          controller: passwordConfirmationController,
          cursorColor: grey2,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
          obscureText: true,
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
                fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
            hintStyle: TextStyle(
              color: grey,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
            ),
            suffixIcon: null,
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    prenomController.dispose();
    eMailController.dispose();
    phoneController.dispose();
    passwordConfirmationController.dispose();
    passwordController.dispose();
  }
}
