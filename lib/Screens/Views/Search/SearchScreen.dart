import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Models/placePredictions.dart';
import 'package:ziouanexpress/Provider/commande.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Assistants/requestAssistant.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Color grey = Color(0xFFC4C4C4);
  Color grey2 = Color(0xFF646464);
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF4ED964);
  Color red = Color(0xFFFF3A32);
  Color orange = Color(0xFFF28322);
  Color blue = Color(0xFF382B8C);
  final Color white = Colors.white;
  var kGoogleApiKey = "AIzaSyC2GWz9vj6BWyIPMGyePxIQb4aqKOcJwz4";
  List<PlacePredictions> placepPredictionList = [];
  final formKey = GlobalKey<FormState>();
  TextEditingController locationexp = TextEditingController();
  TextEditingController locationdes = TextEditingController();
  bool champ;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CommandeProvider>(context, listen: false);
    if ((provider.locationexp != "" || provider.locationdes != "") &&
        locationdes.text == "" &&
        locationexp.text == "") {
      locationexp.text = provider.locationexp;
      locationdes.text = provider.locationdes;
    }

    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    final node = FocusScope.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: CommonSyles.appbar(context, "recherche"),
          backgroundColor: white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Container(
                      height: screenheigh * 0.35,
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
                                top: 18.0,
                                left: 16.0,
                                right: 16.0,
                                bottom: 16.0),
                            child: Container(
                              child: TextFormField(
                                onChanged: (val) {
                                  champ = true;
                                  findplace(val);
                                },
                                controller: locationexp,
                                style: TextStyle(
                                    color: blue,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2),
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
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
                                  hintStyle: TextStyle(
                                    color: grey,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2),
                                    fontFamily: "Nunito",
                                  ),
                                  suffixIcon: Icon(
                                    Icons.my_location_outlined,
                                    color: blue,
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
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, bottom: 10),
                            child: Container(
                              child: TextFormField(
                                onChanged: (val) {
                                  champ = false;
                                  findplace(val);
                                },
                                controller: locationdes,
                                style: TextStyle(
                                    color: blue,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2),
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
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
                                  hintStyle: TextStyle(
                                    color: grey,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(2),
                                    fontFamily: "Nunito",
                                  ),
                                  suffixIcon: Icon(
                                    Icons.location_on_outlined,
                                    color: blue,
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
                          Divider(
                            color: blue,
                            thickness: 3,
                            endIndent: screenwidth * 0.2,
                            indent: screenwidth * 0.2,
                          ),
                          SizedBox(
                            height: screenheigh * 0.01,
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
                                  provider.changelocationdes(locationdes.text);
                                  provider.changelocationexp(locationexp.text);
                                  Navigator.of(context).pop();
                                },
                                color: blue,
                                child: Text("Confirmer",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.3),
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.bold))),
                          ),
                        ],
                      )),
                  (placepPredictionList.length > 0)
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: screenheigh * 0.01, left: screenwidth * 0.1),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (champ == true) {
                                      String exp =
                                          placepPredictionList[index].mainText +
                                              " " +
                                              placepPredictionList[index]
                                                  .secondaryText;
                                      provider.changelocationexp(exp);
                                      locationexp.text = exp;
                                    } else {
                                      String des =
                                          placepPredictionList[index].mainText +
                                              " " +
                                              placepPredictionList[index]
                                                  .secondaryText;
                                      provider.changelocationdes(des);
                                      locationdes.text = des;
                                    }
                                  });
                                  node.requestFocus();
                                },
                                child: PredictionTile(
                                  placePredictions: placepPredictionList[index],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                            itemCount: placepPredictionList.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )),
    );
  }

  void findplace(String placename) async {
    if (placename.length > 2) {
      String autocompleteurl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&key=AIzaSyAP7liOJtATNmGMiTihPlUSrW0qWvZiM44&sessiontoken=1234567890&components=country:DZ";
      var response = await RequestAssistant.getRequest(autocompleteurl);
      if (response == "Failed") {
        print("Failed");
      } else {
        if (response["status"] == "OK") {
          var predictions = response["predictions"];
          var placeslist = (predictions as List)
              .map((e) => PlacePredictions.fromJson(e))
              .toList();
          setState(() {
            placepPredictionList = placeslist;
          });
        } else {}
      }
    }
  }
}

// ignore: must_be_immutable
class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;
  Color blue = Color(0xFF382B8C);
  PredictionTile({Key key, this.placePredictions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (placePredictions.secondaryText == null) {
      placePredictions.secondaryText = "";
    }
    if (placePredictions.mainText == null) {
      placePredictions.mainText = "";
    }
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: blue),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placePredictions.mainText,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    placePredictions.secondaryText,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
