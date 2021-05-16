import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Provider/GeneralProvider.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Services/ApiCalls.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  @override
  _ForgottenPasswordScreenState createState() =>
      _ForgottenPasswordScreenState();
}

class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color orange = Color(0xFFF28322);
  final Color grey2 = Color(0xFF646464);

  final GlobalKey formKey = GlobalKey<FormState>();

  TextEditingController phoneController =
      TextEditingController(text: "0557081936");

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
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
              alignment: Alignment.topCenter,
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
                Positioned(
                  top: ResponsiveFlutter.of(context).hp(5),
                  left: ResponsiveFlutter.of(context).wp(3.5),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: white,
                        size: ResponsiveFlutter.of(context).fontSize(5),
                      ),
                      onPressed: () => Navigator.pop(context)),
                ),
                Positioned(
                  top: ResponsiveFlutter.of(context).hp(15),
                  child: Text(
                    "Rénitialiser votre\nmot de passe",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: white,
                        fontSize: ResponsiveFlutter.of(context).fontSize(3.8),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Nunito"),
                  ),
                ),
                phoneForm(context, node)
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget phoneForm(BuildContext context, FocusNode node) {
    return Positioned(
        top: ResponsiveFlutter.of(context).hp(30),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                        "Veuillez introduire votre numéro de\ntéléphone pour la suite de l'opération",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: violet,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w600,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2.5))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0),
                    child: Container(
                      child: TextFormField(
                        validator: (value) {
                          if (value.length < 10) {
                            return "Veuillez introduire un numéro valide";
                          }
                          return null;
                        },
                        onEditingComplete: () => node.unfocus(),
                        textInputAction: TextInputAction.done,
                        controller: phoneController,
                        cursorColor: grey2,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            letterSpacing: 01,
                            color: grey2,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.bold),
                        decoration: CommonSyles.textDecoration(
                            context, "Numéro de téléphone", null),
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
                      onPressed: () {
                        EasyLoading.show();
                        node.unfocus();
                        Provider.of<GeneralProvider>(context, listen: false)
                            .changeForgettenPhone(phoneController.text);
                        Map data = {
                          "telephone": phoneController.text,
                        };
                        ApiCalls().sendEmail(context, data);
                      },
                      child: Text(
                        "Rénitialiser",
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
}
