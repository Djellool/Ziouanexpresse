import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color grey = Color(0xFFC4C4C4);
  Color grey2 = Color(0xFF646464);
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF4ED964);
  Color red = Color(0xFFFF3A32);
  Color orange = Color(0xFFF28322);
  Color Blue = Color(0xFF382B8C);
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
    print(screenheigh);
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
                  onPressed: () => print('button pressed'),
                  backgroundColor: Blue,
                  child: const Icon(Icons.list, size: 36.0),
                ),
              ),
            ),
            Positioned(
              top: screenheigh * 0.55,
              child: Container(
                  height: screenheigh * 0.45,
                  width: screenwidth,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Blue, spreadRadius: 3),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 16.0, right: 16.0, bottom: 16.0),
                        child: Container(
                          child: TextField(
                            style: TextStyle(
                                color: Blue,
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2),
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              focusColor: Blue,
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
                              labelText: "Location expediteur",
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2.5)),
                              hintText: "Hydra",
                              hintStyle: TextStyle(
                                color: grey,
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2),
                                fontFamily: "Nunito",
                              ),
                              suffixIcon: Icon(
                                Icons.local_shipping,
                                color: Blue,
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
                            left: 16.0, right: 16.0, bottom: 10),
                        child: Container(
                          child: TextField(
                            style: TextStyle(
                                color: Blue,
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2),
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              focusColor: Blue,
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
                              labelText: "Location destinataire",
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2.5)),
                              hintText: "OuedSmar",
                              hintStyle: TextStyle(
                                color: grey,
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2),
                                fontFamily: "Nunito",
                              ),
                              suffixIcon: Icon(
                                Icons.backpack,
                                color: Blue,
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
                      Divider(
                        color: Blue,
                        thickness: 3,
                        endIndent: screenwidth * 0.2,
                        indent: screenwidth * 0.2,
                      ),
                      SizedBox(
                        height: screenheigh * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: screenwidth * 0.45,
                              height: screenheigh * 0.07,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 25,
                                  ),
                                ],
                              ),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0))),
                                  onPressed: () {
                                    print('Button Clicked.');
                                  },
                                  color: Colors.white,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                4, 0, 10, 0),
                                            child: Icon(
                                              Icons.backup,
                                              color: Blue,
                                              size: 30,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            child: Text('Colis',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .fontSize(2.3),
                                                    fontFamily: "Nunito",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      )))),
                          Container(
                              width: screenwidth * 0.45,
                              height: screenheigh * 0.07,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 25,
                                  ),
                                ],
                              ),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0))),
                                  onPressed: () {
                                    print('Button Clicked.');
                                  },
                                  color: Colors.white,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Icon(
                                              Icons.backup,
                                              color: Blue,
                                              size: 30,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            child: Text('Destinataire',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .fontSize(2.3),
                                                    fontFamily: "Nunito",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      )))),
                        ],
                      ),
                      SizedBox(
                        height: screenheigh * 0.02,
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
                            onPressed: () {
                              print('Button Clicked.');
                            },
                            color: Blue,
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
    );
  }
}
