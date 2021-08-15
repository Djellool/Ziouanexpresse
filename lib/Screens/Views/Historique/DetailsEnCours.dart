import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Services/ApiCalls.dart';

class DetailsEnCours extends StatefulWidget {
  final int idLivraison;
  DetailsEnCours(this.idLivraison);
  @override
  _DetailsEnCoursState createState() => _DetailsEnCoursState();
}

class _DetailsEnCoursState extends State<DetailsEnCours> {
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color orange = Color(0xFFF28322);
  final Color blue = Color(0xFF382B8C);
  final Color grey2 = Color(0xFF646464);

  int activeStep = 2; // Initial step set to 5.

  int upperBound = 3;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: ApiCalls().getHistoriqueDetail(
              Provider.of<AuthProvider>(context).token, widget.idLivraison),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: CommonSyles.appbar(context, "Détails de livraison"),
                body: Container(
                  height: 700,
                  width: ResponsiveFlutter.of(context).wp(100),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: avatar(context,
                              snapshot.data.nom + snapshot.data.prenom),
                        ),
                        Center(
                            child:
                                price(context, snapshot.data.prix.toString())),
                        Expanded(
                          child: Container(
                            width: 100,
                            child: NumberStepper(
                              enableNextPreviousButtons: false,
                              activeStepColor: orange,
                              activeStepBorderColor: blue,
                              activeStepBorderWidth: 3,
                              activeStepBorderPadding: 0,
                              stepRadius: 26,
                              numberStyle: TextStyle(
                                  color: white,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w600,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(4)),
                              stepColor: blue,
                              direction: Axis.vertical,
                              numbers: [1, 2, 3, 4, 5],

                              // activeStep property set to activeStep variable defined above.
                              activeStep: activeStep,

                              // This ensures step-tapping updates the activeStep.
                              onStepReached: (index) {
                                setState(() {
                                  activeStep = index;
                                });
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return SpinKitFadingCube(
              color: violet,
            );
          }),
    );
  }

  Widget avatar(BuildContext context, String nomPrenom) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(20)),
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: Color(0xFF382B8C),
              radius: ResponsiveFlutter.of(context).scale(45),
              child: CircleAvatar(
                backgroundColor: white,
                radius: ResponsiveFlutter.of(context).scale(43),
                backgroundImage: AssetImage("assets/images/avatar.png"),
              )),
          Text(
            nomPrenom,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: violet,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveFlutter.of(context).fontSize(4)),
          )
        ],
      ),
    );
  }

  Widget price(BuildContext context, String prix) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ResponsiveFlutter.of(context).scale(12)),
      child: Text(
        prix.toString() + " DA",
        style: TextStyle(
            color: violet,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveFlutter.of(context).fontSize(5)),
      ),
    );
  }
}
