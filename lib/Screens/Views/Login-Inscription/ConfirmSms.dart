import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Provider/GeneralProvider.dart';
import 'package:ziouanexpress/Provider/InscriptionProvider.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';

class ConfirmSmsScreen extends StatefulWidget {
  @override
  _ConfirmSmsScreenState createState() => _ConfirmSmsScreenState();
}

class _ConfirmSmsScreenState extends State<ConfirmSmsScreen> {
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color orange = Color(0xFFF28322);
  final Color grey2 = Color(0xFF646464);

  String phoneNumber;

  final GlobalKey formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final CustomTimerController _controller = new CustomTimerController();

  void onFinish() {
    Provider.of<GeneralProvider>(context, listen: false)
        .changeRenvoyerIns(null);
  }

  @override
  Widget build(BuildContext context) {
    final _pinPutFocusNode = FocusNode();

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
                    "Confirmer votre numéro",
                    style: TextStyle(
                        color: white,
                        fontSize: ResponsiveFlutter.of(context).fontSize(3.8),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Nunito"),
                  ),
                ),
                smsForm(context, _pinPutFocusNode)
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget smsForm(BuildContext context, FocusNode node) {
    String phoneNumber =
        Provider.of<InscriptionProvider>(context, listen: false).phoneNumber;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                            "Veuillez entrer le code reçu par SMS\nsur +213$phoneNumber",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: violet,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveFlutter.of(context)
                                    .fontSize(2.5))),
                      ),
                      _buildSMSField(node),
                    ],
                  ),
                  renvoyerfield()
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildSMSField(FocusNode node) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: PinPut(
        onTap: () => print("12365"),
        fieldsCount: 6,
        textStyle: TextStyle(
            fontFamily: "Nunito",
            fontSize: ResponsiveFlutter.of(context).fontSize(4.5),
            color: Color(0xFF382B8C)),
        eachFieldWidth: ResponsiveFlutter.of(context).scale(45),
        eachFieldHeight: ResponsiveFlutter.of(context).scale(55),
        focusNode: node,
        controller: _pinPutController,
        submittedFieldDecoration: CommonSyles.pinDecoration(),
        selectedFieldDecoration: CommonSyles.pinDecoration(),
        followingFieldDecoration: CommonSyles.pinDecoration(),
        pinAnimationType: PinAnimationType.fade,
        onSubmit: (pin) async {},
      ),
    );
  }

  Widget renvoyerfield() {
    bool renvoyer = Provider.of<GeneralProvider>(context).renvoyerIns;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Code non reçu ?",
                style: TextStyle(
                    color: grey2,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.2),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w600),
              ),
              FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    if (renvoyer) {
                      _controller.reset();
                      _controller.start();
                      Provider.of<GeneralProvider>(context, listen: false)
                          .changeRenvoyerIns(null);
                    }
                  },
                  child: Text(
                    "Renvoyer",
                    style: TextStyle(
                        color: renvoyer ? violet : grey,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.2)),
                  ))
            ],
          ),
          CustomTimer(
            controller: _controller,
            from: Duration(seconds: 5),
            to: Duration(hours: 0),
            onBuildAction: CustomTimerAction.auto_start,
            onFinish: onFinish,
            builder: (CustomTimerRemainingTime remaining) {
              return Text(
                "${remaining.minutes}:${remaining.seconds}",
                style: TextStyle(
                    color: violet,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pinPutController.dispose();
  }
}
