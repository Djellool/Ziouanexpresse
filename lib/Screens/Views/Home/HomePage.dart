import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Components/icons_class.dart';

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
    TextEditingController locationexp = TextEditingController();
    TextEditingController locationdes = TextEditingController();
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: NavDrawer(),
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
                    scaffoldKey.currentState.openDrawer();
                  },
                  backgroundColor: blue,
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
                      BoxShadow(color: blue, spreadRadius: 3),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 16.0, right: 16.0, bottom: 16.0),
                        child: Container(
                          child: TextField(
                            controller: locationexp,
                            style: TextStyle(
                                color: blue,
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2),
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
                                color: blue,
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
                            controller: locationdes,
                            style: TextStyle(
                                color: blue,
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2),
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
                                color: blue,
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
                        color: blue,
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
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildPopupDialog(context),
                                    );
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
                                              color: blue,
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
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildPopupDialogdestinataire(
                                              context),
                                    );
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
                                              color: blue,
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
                            color: blue,
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

  Widget _buildPopupDialog(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    String selectedUser;
    List<String> _fragilite = ['Tres Fragile', 'Fragile', 'Solide'];
    TextEditingController dimension = TextEditingController(text: "200 x 500");
    TextEditingController poids = TextEditingController(text: "16 kg");
    TextEditingController value = TextEditingController(text: "30000");
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: blue,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ),
          Center(
              child: Text('Veillez introduire les informations du colis',
                  style: TextStyle(
                      color: blue,
                      fontSize: ResponsiveFlutter.of(context).fontSize(3),
                      fontWeight: FontWeight.bold))),
          SizedBox(
            height: screenheigh * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 6.0, right: 6.0),
            child: Container(
              child: TextField(
                controller: dimension,
                style: TextStyle(
                    color: grey2,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold),
                decoration: CommonSyles.textDecoration(
                    context,
                    "Dimensions(HxLxP)",
                    Icon(
                      IconsClass.cube_with_arrows,
                      color: blue,
                    )),
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
            padding: const EdgeInsets.only(top: 15, left: 6.0, right: 6.0),
            child: Container(
              child: TextField(
                controller: poids,
                cursorColor: grey2,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: grey2,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold),
                decoration: CommonSyles.textDecoration(
                    context,
                    "poid",
                    Icon(
                      IconsClass.weight,
                      color: blue,
                    )),
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
            padding: const EdgeInsets.only(top: 15, left: 6.0, right: 6.0),
            child: Container(
              child: TextField(
                controller: value,
                cursorColor: grey2,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: grey2,
                    fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold),
                decoration: CommonSyles.textDecoration(
                    context,
                    "valeur ( DA )",
                    Icon(
                      IconsClass.price_tag,
                      color: blue,
                    )),
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
            padding: const EdgeInsets.only(top: 15, left: 6.0, right: 6.0),
            child: Container(
              child: DropdownButtonFormField<String>(
                decoration:
                    CommonSyles.textDecoration(context, "Fragilite", null),
                value: selectedUser,
                onChanged: (String value) {
                  setState(() {
                    selectedUser = value;
                  });
                },
                items: _fragilite.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
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
            height: screenheigh * 0.02,
          ),
          Center(
            child: Container(
              height: screenheigh * 0.06,
              width: screenwidth * 0.4,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0))),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  color: blue,
                  child: Text("Confirmer",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupDialogdestinataire(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    TextEditingController nom = TextEditingController();
    TextEditingController prenom = TextEditingController();
    TextEditingController telephone = TextEditingController();
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: blue,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ),
          Center(
              child: Text('Veillez introduire les informations du destinataire',
                  style: TextStyle(
                      color: blue,
                      fontSize: ResponsiveFlutter.of(context).fontSize(3),
                      fontWeight: FontWeight.bold))),
          SizedBox(
            height: screenheigh * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 6.0, right: 6.0),
            child: Container(
              child: TextField(
                controller: nom,
                style: TextStyle(
                    color: grey2,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold),
                decoration: CommonSyles.textDecoration(
                    context,
                    "Nom",
                    Icon(
                      Icons.account_box,
                      color: blue,
                    )),
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
            padding: const EdgeInsets.only(top: 15, left: 6.0, right: 6.0),
            child: Container(
              child: TextField(
                controller: prenom,
                cursorColor: grey2,
                style: TextStyle(
                    color: grey2,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold),
                decoration: CommonSyles.textDecoration(
                    context,
                    "Prenom",
                    Icon(
                      Icons.account_box,
                      color: blue,
                    )),
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
            padding: const EdgeInsets.only(top: 15, left: 6.0, right: 6.0),
            child: Container(
              child: TextField(
                controller: telephone,
                cursorColor: grey2,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: grey2,
                    fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold),
                decoration: CommonSyles.textDecoration(
                    context,
                    "Telephone",
                    Icon(
                      Icons.phone,
                      color: blue,
                    )),
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
            height: screenheigh * 0.02,
          ),
          Center(
            child: Container(
              height: screenheigh * 0.06,
              width: screenwidth * 0.4,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0))),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  color: blue,
                  child: Text("Confirmer",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final Color violet = Color(0xFF382B8C);
  final Color blue = Color(0xFF382B8C);
  @override
  Widget build(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), bottomRight: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 25,
          ),
        ],
      ),
      height: screenheigh,
      width: screenwidth - screenwidth * 0.1,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/image1.jpg",
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: screenwidth * 0.9,
                    height: screenheigh * 1,
                    color: violet.withOpacity(0.8),
                  ),
                ),
                logo(context)
              ],
            ),
          ),
          SizedBox(height: screenheigh * 0.04),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: blue,
              size: 45,
            ),
            title: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveFlutter.of(context).fontSize(3)),
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: screenheigh * 0.02),
          ListTile(
            leading: Icon(
              Icons.history,
              color: blue,
              size: 45,
            ),
            title: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Historique',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveFlutter.of(context).fontSize(3)),
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: screenheigh * 0.02),
          ListTile(
            leading: Icon(
              Icons.money_off_csred_rounded,
              size: 45,
              color: blue,
            ),
            title: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Promotions',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveFlutter.of(context).fontSize(3)),
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: screenheigh * 0.02),
          ListTile(
            leading: Icon(
              Icons.group_rounded,
              size: 45,
              color: blue,
            ),
            title: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Parrainage',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveFlutter.of(context).fontSize(3)),
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: screenheigh * 0.15),
          Center(
            child: Text(
              "Pour ne rien rater , suivez nous :",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
            ),
          ),
          SizedBox(height: screenheigh * 0.03),
          Container(
            width: screenwidth * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: SignInButton(
                    Buttons.Facebook,
                    onPressed: () {},
                    mini: true,
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: SignInButton(
                    Buttons.Pinterest,
                    onPressed: () {},
                    mini: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget logo(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Positioned(
        top: screenheigh * 0.07,
        left: screenwidth * 0.25,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: ResponsiveFlutter.of(context).wp(40),
            height: ResponsiveFlutter.of(context).hp(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Image.asset("assets/images/Logo.png"),
          ),
        ));
  }
}
