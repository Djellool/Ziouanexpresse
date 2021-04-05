import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Components/icons_class.dart';

class Promotion extends StatefulWidget {
  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  final Color background = Color(0xFFF2F2F2);
  final Color orange = Color(0xFFF28322);
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color grey2 = Color(0xFF646464);

  @override
  Widget build(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: CommonSyles.appbar(context, "Promotion"),
        backgroundColor: white,
        body: Container(
          height: screenheigh,
          child: Stack(
            children: <Widget>[
              Container(
                height: screenheigh * 0.63,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: screenheigh * 0.015,
                    ),
                    Container(
                      width: screenwidth * 0.9,
                      decoration: CommonSyles.containerDecoration(context),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, right: 22, left: 16, top: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "30% de reduction sur votre prochaine livraison",
                                style: TextStyle(
                                    color: violet,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2.2)),
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Code promo : ',
                                          style: TextStyle(
                                              color: grey,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.8)),
                                        ),
                                        TextSpan(
                                          text: 'Djelloul',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Actif",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.bold,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Valable jusqu'a : ",
                                      style: TextStyle(
                                          color: grey,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(1.8)),
                                    ),
                                    TextSpan(
                                      text: '21h',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: screenheigh * 0.015,
                    ),
                    Container(
                      width: screenwidth * 0.9,
                      decoration: CommonSyles.containerDecoration(context),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, right: 22, left: 16, top: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "50% de reduction sur votre prochaine livraison",
                                style: TextStyle(
                                    color: violet,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2.2)),
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Code promo : ',
                                          style: TextStyle(
                                              color: grey,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.8)),
                                        ),
                                        TextSpan(
                                          text: 'AMINE',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Actif",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.bold,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Valable jusqu'a : ",
                                      style: TextStyle(
                                          color: grey,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(1.8)),
                                    ),
                                    TextSpan(
                                      text: '16h',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: screenheigh * 0.015,
                    ),
                    Opacity(
                      opacity: 0.4,
                      child: Container(
                        width: screenwidth * 0.9,
                        decoration: CommonSyles.containerDecoration(context),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 16, right: 22, left: 16, top: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "20% de reduction sur votre prochaine livraison",
                                  style: TextStyle(
                                      color: violet,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.bold,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.2)),
                                ),
                                SizedBox(
                                  height: screenheigh * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Code promo : ',
                                            style: TextStyle(
                                                color: grey,
                                                fontFamily: "Nunito",
                                                fontWeight: FontWeight.bold,
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(1.8)),
                                          ),
                                          TextSpan(
                                            text: 'HaHaHaHaHa',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Nunito",
                                                fontWeight: FontWeight.bold,
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Utilisé",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.2)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenheigh * 0.01,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Plus valable depuis le : ",
                                        style: TextStyle(
                                            color: grey,
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(1.8)),
                                      ),
                                      TextSpan(
                                        text: '20/03/2021',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(2)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: screenheigh * 0.015,
                    ),
                    Container(
                      width: screenwidth * 0.9,
                      decoration: CommonSyles.containerDecoration(context),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, right: 22, left: 16, top: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "30% de reduction sur votre prochaine livraison",
                                style: TextStyle(
                                    color: violet,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2.2)),
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Code promo : ',
                                          style: TextStyle(
                                              color: grey,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.8)),
                                        ),
                                        TextSpan(
                                          text: 'Djelloul',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Actif",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.bold,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Valable jusqu'a : ",
                                      style: TextStyle(
                                          color: grey,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(1.8)),
                                    ),
                                    TextSpan(
                                      text: '21h',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: screenheigh * 0.015,
                    ),
                    Container(
                      width: screenwidth * 0.9,
                      decoration: CommonSyles.containerDecoration(context),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, right: 22, left: 16, top: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "30% de reduction sur votre prochaine livraison",
                                style: TextStyle(
                                    color: violet,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2.2)),
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Code promo : ',
                                          style: TextStyle(
                                              color: grey,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.8)),
                                        ),
                                        TextSpan(
                                          text: 'Djelloul',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Actif",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.bold,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Valable jusqu'a : ",
                                      style: TextStyle(
                                          color: grey,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(1.8)),
                                    ),
                                    TextSpan(
                                      text: '21h',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: screenheigh * 0.015,
                    ),
                    Container(
                      width: screenwidth * 0.9,
                      decoration: CommonSyles.containerDecoration(context),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, right: 22, left: 16, top: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "30% de reduction sur votre prochaine livraison",
                                style: TextStyle(
                                    color: violet,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2.2)),
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Code promo : ',
                                          style: TextStyle(
                                              color: grey,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.8)),
                                        ),
                                        TextSpan(
                                          text: 'Djelloul',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(2)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Actif",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.bold,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenheigh * 0.01,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Valable jusqu'a : ",
                                      style: TextStyle(
                                          color: grey,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(1.8)),
                                    ),
                                    TextSpan(
                                      text: '21h',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    height: screenheigh * 0.25,
                    width: screenwidth,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: violet, spreadRadius: 3),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenheigh * 0.05,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Container(
                            child: TextField(
                              style: TextStyle(
                                  color: violet,
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(2),
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
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
                                labelText: "Code promo",
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2.5)),
                                hintText: "Enter Code Promo",
                                hintStyle: TextStyle(
                                  color: grey,
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(2),
                                  fontFamily: "Nunito",
                                ),
                                suffixIcon: Icon(
                                  IconsClass.price_tag,
                                  color: violet,
                                  size: 30,
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
                        SizedBox(
                          height: screenheigh * 0.025,
                        ),
                        Container(
                          height: screenheigh * 0.06,
                          width: screenwidth * 0.6,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0))),
                              onPressed: () {},
                              color: violet,
                              child: Text("Commander",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2.3),
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
