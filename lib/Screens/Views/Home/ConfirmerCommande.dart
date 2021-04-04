import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Components/icons_class.dart';

class ConfirmerCommande extends StatefulWidget {
  @override
  _ConfirmerCommandeState createState() => _ConfirmerCommandeState();
}

class _ConfirmerCommandeState extends State<ConfirmerCommande> {
  Color grey = Color(0xFFC4C4C4);
  Color grey2 = Color(0xFF646464);
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF4ED964);
  Color red = Color(0xFFFF3A32);
  Color orange = Color(0xFFF28322);
  Color blue = Color(0xFF382B8C);
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  // This widget is the root of your application.
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    TextEditingController Locationexp =
        TextEditingController(text: "El Herrach");
    TextEditingController Locationdes =
        TextEditingController(text: "Ain naadja");
    TextEditingController dimension = TextEditingController(text: "400 x 600");
    TextEditingController poids = TextEditingController(text: "12.5 kg");
    TextEditingController valeur = TextEditingController(text: "15000");
    TextEditingController fragilite = TextEditingController(text: "Solide");
    TextEditingController Nom = TextEditingController(text: "Yessad");
    TextEditingController Prenom = TextEditingController(text: "Samy");
    TextEditingController Telephone = TextEditingController(text: "0561403441");
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: blue,
                  child: const Icon(Icons.arrow_back, size: 36.0),
                ),
              ),
            ),
            Positioned(
                top: screenheigh * 0.2,
                child: Container(
                  height: screenheigh * 0.8,
                  width: screenwidth,
                  child: MaterialApp(
                    home: DefaultTabController(
                      length: 3,
                      child: Scaffold(
                          body: Column(
                        children: <Widget>[
                          TabBar(
                            indicatorWeight: 5,
                            indicatorColor: blue,
                            tabs: [
                              Tab(
                                  icon: Icon(
                                IconsClass.delivery,
                                color: blue,
                                size: 35,
                              )),
                              Tab(
                                  icon: Icon(
                                IconsClass.package,
                                color: blue,
                                size: 32,
                              )),
                              Tab(
                                  icon: Icon(
                                Icons.account_box_outlined,
                                color: blue,
                                size: 35,
                              )),
                            ],
                          ),
                          Expanded(
                            flex: 3,
                            child: TabBarView(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 16.0,
                                          right: 16.0,
                                        ),
                                        child: Container(
                                          child: TextField(
                                              controller: Locationexp,
                                              readOnly: true,
                                              style: TextStyle(
                                                  color: blue,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold),
                                              decoration:
                                                  CommonSyles.textDecoration(
                                                      context,
                                                      "Location expediteur",
                                                      Icon(
                                                        IconsClass.truck,
                                                        color: blue,
                                                        size: 35,
                                                      ))),
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
                                            left: 16.0,
                                            right: 16.0,
                                            bottom: 10),
                                        child: Container(
                                          child: TextField(
                                              controller: Locationdes,
                                              readOnly: true,
                                              style: TextStyle(
                                                  color: blue,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold),
                                              decoration:
                                                  CommonSyles.textDecoration(
                                                      context,
                                                      "Location destinataire",
                                                      Icon(
                                                        IconsClass.package,
                                                        color: blue,
                                                        size: 30,
                                                      ))),
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
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 16.0,
                                          right: 16.0,
                                        ),
                                        child: Container(
                                          child: TextField(
                                              controller: dimension,
                                              readOnly: true,
                                              style: TextStyle(
                                                  color: blue,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold),
                                              decoration:
                                                  CommonSyles.textDecoration(
                                                      context,
                                                      "Dimensions ( HxL )",
                                                      Icon(
                                                        IconsClass
                                                            .cube_with_arrows,
                                                        color: blue,
                                                        size: 35,
                                                      ))),
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
                                            left: 16.0,
                                            right: 16.0,
                                            bottom: 10),
                                        child: Container(
                                          child: TextField(
                                              controller: poids,
                                              readOnly: true,
                                              style: TextStyle(
                                                  color: blue,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold),
                                              decoration:
                                                  CommonSyles.textDecoration(
                                                      context,
                                                      "Poids",
                                                      Icon(
                                                        IconsClass.weight,
                                                        color: blue,
                                                        size: 30,
                                                      ))),
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
                                            left: 16.0,
                                            right: 16.0,
                                            bottom: 10),
                                        child: Container(
                                          child: TextField(
                                              controller: valeur,
                                              readOnly: true,
                                              style: TextStyle(
                                                  color: blue,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold),
                                              decoration:
                                                  CommonSyles.textDecoration(
                                                      context,
                                                      "Valeur",
                                                      Icon(
                                                        IconsClass.price_tag,
                                                        color: blue,
                                                        size: 30,
                                                      ))),
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
                                            left: 16.0,
                                            right: 16.0,
                                            bottom: 10),
                                        child: Container(
                                          child: TextField(
                                              controller: fragilite,
                                              readOnly: true,
                                              style: TextStyle(
                                                  color: blue,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold),
                                              decoration:
                                                  CommonSyles.textDecoration(
                                                      context,
                                                      "Fragilite",
                                                      Icon(
                                                        Icons
                                                            .accessible_forward_rounded,
                                                        color: blue,
                                                        size: 30,
                                                      ))),
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
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0,
                                            right: 16.0,
                                            bottom: 10),
                                        child: Container(
                                          child: TextField(
                                              controller: Nom,
                                              readOnly: true,
                                              style: TextStyle(
                                                  color: blue,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold),
                                              decoration:
                                                  CommonSyles.textDecoration(
                                                      context,
                                                      "Nom",
                                                      Icon(
                                                        Icons.account_circle,
                                                        color: blue,
                                                        size: 30,
                                                      ))),
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
                                            left: 16.0,
                                            right: 16.0,
                                            bottom: 10),
                                        child: Container(
                                          child: TextField(
                                              controller: Prenom,
                                              readOnly: true,
                                              style: TextStyle(
                                                  color: blue,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold),
                                              decoration:
                                                  CommonSyles.textDecoration(
                                                      context,
                                                      "Prenom",
                                                      Icon(
                                                        Icons.account_circle,
                                                        color: blue,
                                                        size: 30,
                                                      ))),
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
                                            left: 16.0,
                                            right: 16.0,
                                            bottom: 10),
                                        child: Container(
                                          child: TextField(
                                              controller: Telephone,
                                              readOnly: true,
                                              style: TextStyle(
                                                  color: blue,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold),
                                              decoration:
                                                  CommonSyles.textDecoration(
                                                      context,
                                                      "Numero de telephone",
                                                      Icon(
                                                        Icons.phone,
                                                        color: blue,
                                                        size: 30,
                                                      ))),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Center(
                                    child: Text("1560 Da",
                                        style: TextStyle(
                                            color: grey,
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(5),
                                            decoration:
                                                TextDecoration.lineThrough)),
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text("870 Da",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: blue,
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(5),
                                            )),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25, top: 14),
                                          child: Text("-25%",
                                              style: TextStyle(
                                                color: red,
                                                fontFamily: "Nunito",
                                                fontWeight: FontWeight.bold,
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(3.5),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenheigh * 0.02,
                                  ),
                                  Container(
                                    height: ResponsiveFlutter.of(context).hp(7),
                                    width: ResponsiveFlutter.of(context).wp(60),
                                    decoration: BoxDecoration(
                                      color: blue,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    child: FlatButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Confirmer",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Nunito",
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(3)),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
