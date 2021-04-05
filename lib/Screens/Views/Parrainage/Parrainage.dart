import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Components/icons_class.dart';

class Parrainage extends StatefulWidget {
  @override
  _ParrainageState createState() => _ParrainageState();
}

class _ParrainageState extends State<Parrainage> {
  final Color background = Color(0xFFF2F2F2);
  final Color orange = Color(0xFFF28322);
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color grey2 = Color(0xFF646464);

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Code de referencement',
      text: 'Ziouane Code refereneceent',
      linkUrl: 'https://flutter.dev/',
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: CommonSyles.appbar(context, "Parrainage"),
          backgroundColor: white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Vous avez : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.bold,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(3)),
                      ),
                      TextSpan(
                        text: ' 175 ',
                        style: TextStyle(
                            color: violet,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.bold,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(6)),
                      ),
                      TextSpan(
                        text: 'pts',
                        style: TextStyle(
                            color: violet,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.bold,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(3)),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Invitez vos amis en partageant votre\ncode pour gagner pleins de surprises",
                  style: TextStyle(
                      color: violet,
                      fontFamily: "Nunito",
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
                ),
              ),
              SizedBox(
                height: screenheigh * 0.02,
              ),
              Container(
                height: screenheigh * 0.4,
                width: screenwidth,
                child: Image.asset(
                  'assets/images/image1.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Text(
                  "Votre code :",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Nunito",
                      fontSize: ResponsiveFlutter.of(context).fontSize(3)),
                ),
              ),
              SizedBox(
                height: screenheigh * 0.01,
              ),
              Center(
                child: Text(
                  "DjillaliXyehs",
                  style: TextStyle(
                      color: violet,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveFlutter.of(context).fontSize(5)),
                ),
              ),
              SizedBox(
                height: screenheigh * 0.03,
              ),
              Center(
                child: Container(
                  height: screenheigh * 0.075,
                  width: screenwidth * 0.5,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                      onPressed: () {
                        share();
                      },
                      color: violet,
                      child: Text("Partager",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.3),
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          )),
    );
  }
}
