import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ziouanexpress/Assistants/HelperMethods.dart';
import 'package:ziouanexpress/Assistants/firehelper.dart';
import 'package:ziouanexpress/Assistants/globalvariables.dart';
import 'package:ziouanexpress/Models/DirectionDetails.dart';
import 'package:ziouanexpress/Models/Nearbydriver.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Provider/commande.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Components/icons_class.dart';
import 'package:ziouanexpress/Screens/Views/Historique/Historique.dart';
import 'package:ziouanexpress/Screens/Views/Parrainage/Parrainage.dart';
import 'package:ziouanexpress/Screens/Views/Profile/Profile.dart';
import 'package:ziouanexpress/Screens/Views/Promotion/Promotion.dart';
import 'dart:io';
import 'package:location/location.dart';
import 'package:ziouanexpress/Screens/Views/Search/SearchScreen.dart';
import 'package:ziouanexpress/Services/ApiCalls.dart';
import 'package:ziouanexpress/Services/Maps.dart';

import 'ConfirmerCommande.dart';

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
  Location _location = Location();
  LatLng latlngposition;
  var kGoogleApiKey = "AIzaSyC2GWz9vj6BWyIPMGyePxIQb4aqKOcJwz4";

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  bool nearbyDriversKeysLoaded = false;
  BitmapDescriptor nearbyIcon;
  List<NearbyDriver> availableDrivers;
  String appState = 'NORMAL';
  String selecteddimension;
  String selectedUser;

  // ignore: unused_field
  GoogleMapController _controller;

  // This widget is the root of your application.
  Future<void> _onMapCreated(GoogleMapController _cntlr) async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _controller = _cntlr;
    startGeofireListener(
        LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  void startGeofireListener(LatLng currentPosition) {
    print("Before length :" + FireHelper.nearbyDriverList.length.toString());
    Geofire.initialize('driversAvailable');
    Geofire.queryAtLocation(
            currentPosition.latitude, currentPosition.longitude, 20)
        .listen((map) {
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyDriver nearbyDriver = NearbyDriver();
            nearbyDriver.key = map['key'];
            print("entered key = " + nearbyDriver.key.toString());
            nearbyDriver.latitude = map['latitude'];
            nearbyDriver.longitude = map['longitude'];
            if (FireHelper.contains(map['key']) == true) {
              print(map['key'].toString() + " Contains");
            } else {
              print("Adding");
              FireHelper.nearbyDriverList.add(nearbyDriver);
            }
            if (nearbyDriversKeysLoaded) {
              updateDriversOnMap();
            }
            break;

          case Geofire.onKeyExited:
            FireHelper.removeFromList(map['key']);
            updateDriversOnMap();
            break;
          case Geofire.onKeyMoved:
            // Update your key's location

            NearbyDriver nearbyDriver = NearbyDriver();
            nearbyDriver.key = map['key'];
            nearbyDriver.latitude = map['latitude'];
            nearbyDriver.longitude = map['longitude'];

            FireHelper.updateNearbyLocation(nearbyDriver);
            updateDriversOnMap();
            break;

          case Geofire.onGeoQueryReady:
            nearbyDriversKeysLoaded = true;
            updateDriversOnMap();
            break;
        }
      }
    });
  }

  void updateDriversOnMap() {
    Set<Marker> tempMarkers = Set<Marker>();

    for (NearbyDriver driver in FireHelper.nearbyDriverList) {
      LatLng driverPosition = LatLng(driver.latitude, driver.longitude);
      Marker thisMarker = Marker(
        markerId: MarkerId('driver${driver.key}'),
        position: driverPosition,
        icon: nearbyIcon,
        rotation: HelperMethods.generateRandomNumber(360),
      );
      print(thisMarker.position.longitude.toString());

      tempMarkers.add(thisMarker);
    }
    if (!mounted) return;
    setState(() {
      markersSet = tempMarkers;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Alert(
      context: context,
      type: AlertType.error,
      title: "Erreur",
      desc: "Veuillez saisir toutes les informations pour continuer !!",
      buttons: [
        DialogButton(
          color: blue,
          radius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
          child: Text(
            "Retour",
            style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveFlutter.of(context).fontSize(3),
                fontFamily: "Nunito"),
          ),
          onPressed: () => Navigator.pop(context),
          width: ResponsiveFlutter.of(context).wp(40),
          height: ResponsiveFlutter.of(context).wp(15),
        )
      ],
    ).show();
  }

  TextEditingController poids = TextEditingController();
  TextEditingController value = TextEditingController();
  TextEditingController locationexp = TextEditingController();
  TextEditingController locationdes = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController telephone = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> _selections = [true, false];

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void dispose() {
    telephone.dispose();
    prenom.dispose();
    nom.dispose();
    locationdes.dispose();
    locationexp.dispose();
    value.dispose();
    poids.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    createMarker();
    var provider = Provider.of<CommandeProvider>(context, listen: false);
    locationexp.text = provider.locationexp;
    locationdes.text = provider.locationdes;

    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: NavDrawer(),
        body: Stack(
          children: <Widget>[
            FutureBuilder(
                future: _location.getLocation(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final MarkerId markerId = MarkerId("443");
                    currentPosition = snapshot.data;
                    var positionactuelle =
                        LatLng(snapshot.data.latitude, snapshot.data.longitude);
                    if (markersSet.isEmpty) {
                      print("IsEmpty");
                      Marker marker = new Marker(
                          markerId: markerId,
                          position: LatLng(positionactuelle.latitude,
                              positionactuelle.longitude));
                      // adding a new marker to map
                      markersSet.add(marker.copyWith(
                          positionParam: LatLng(positionactuelle.latitude,
                              positionactuelle.longitude)));
                    }
                    return _buildGoogleMap(context, positionactuelle);
                  } else if (snapshot.hasError) {
                    return Text("Erreur");
                  }
                  // By default, show a loading spinner.
                  return Center(child: CircularProgressIndicator());
                }),
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
              bottom: screenheigh * 0.44,
              left: screenwidth * 0.05,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                child: ToggleButtons(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  selectedColor: Colors.white,
                  fillColor: blue,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "Depart",
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "Arrive",
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < _selections.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          _selections[buttonIndex] = true;
                        } else {
                          _selections[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  isSelected: _selections,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  height: screenheigh * 0.43,
                  width: screenwidth,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: blue, spreadRadius: 3),
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  ResponsiveFlutter.of(context).scale(15),
                              vertical:
                                  ResponsiveFlutter.of(context).scale(13)),
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veillez entrer la location de depart';
                                }
                                return null;
                              },
                              onTap: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchScreen()))
                                    .then((value) => setState(() {}));
                              },
                              readOnly: true,
                              controller: locationexp,
                              style: TextStyle(
                                  color: blue,
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(2),
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
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(2),
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
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  ResponsiveFlutter.of(context).scale(15),
                              vertical: ResponsiveFlutter.of(context).scale(5)),
                          child: Container(
                            child: TextFormField(
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veillez entrer la location d'entree";
                                }
                                return null;
                              },
                              onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchScreen()))
                                  .then((value) => setState(() {})),
                              controller: locationdes,
                              style: TextStyle(
                                  color: blue,
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(2),
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
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(2),
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
                                            bottomRight:
                                                Radius.circular(20.0))),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupDialog(context),
                                      );
                                    },
                                    color: Colors.white,
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
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
                                            bottomRight:
                                                Radius.circular(20.0))),
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Icon(
                                                Icons.backup,
                                                color: blue,
                                                size: 30,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: Text('Destinataire',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .fontSize(2.1),
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
                              onPressed: () async {
                                if (provider.locationdes != null &&
                                    provider.locationexp != null &&
                                    provider.dimension != null &&
                                    provider.poids != null &&
                                    provider.fragilite != null &&
                                    provider.valeur != null &&
                                    provider.nomdest != null &&
                                    provider.prenomdest != null &&
                                    provider.teldest != null) {
                                  if (provider.locationdes.trim().isNotEmpty &&
                                      provider.locationexp.trim().isNotEmpty &&
                                      provider.dimension.trim().isNotEmpty &&
                                      provider.fragilite.trim().isNotEmpty &&
                                      provider.nomdest.trim().isNotEmpty &&
                                      provider.prenomdest.trim().isNotEmpty &&
                                      provider.teldest.trim().isNotEmpty) {
                                    var authprovider =
                                        Provider.of<AuthProvider>(context,
                                            listen: false);
                                    EasyLoading.show();
                                    Geofire.stopListener();
                                    FireHelper.nearbyDriverList.clear();
                                    var promotions = await ApiCalls()
                                        .getPromotions(authprovider.token,
                                            authprovider.client.idClient);
                                    nbpromotions = promotions.length;
                                    DirectionDetails directionDetails =
                                        await Maps.obtainPlaceDirectionsDetails(
                                            context,
                                            provider.locationexp,
                                            provider.locationdes);
                                    provider.changeduration(double.tryParse(
                                            directionDetails.durationValue
                                                .toString()) /
                                        60);
                                    provider.changedistance(double.tryParse(
                                            directionDetails.distanceValue
                                                .toString()) /
                                        1000);
                                    price =
                                        provider.duration * prixunitaireminute +
                                            provider.distance * prixunitairekm +
                                            prixarbitraire;
                                    EasyLoading.dismiss();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmerCommande()));
                                  } else {
                                    showAlertDialog(context);
                                  }
                                } else {
                                  showAlertDialog(context);
                                }
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
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  getUserLocation() async {
    var provider = Provider.of<CommandeProvider>(context, listen: false);
    markersSet.forEach((value) async {
      // From coordinates
      final coordinates =
          new Coordinates(value.position.latitude, value.position.longitude);
      var addresses = await Geocoder.google(kGoogleApiKey)
          .findAddressesFromCoordinates(coordinates);
      if (_selections.first == true) {
        provider.changelocationexp(addresses.first.featureName);
        locationexp.text = addresses.first.featureName;
      } else {
        provider.changelocationdes(addresses.first.featureName);
        locationdes.text = addresses.first.featureName;
      }
    });
  }

  Widget _buildGoogleMap(BuildContext context, LatLng locationactuelle) {
    var screenheigh = MediaQuery.of(context).size.height;
    return Container(
      height: screenheigh * 0.56,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target:
                LatLng(locationactuelle.latitude, locationactuelle.longitude),
            zoom: 13),
        markers: markersSet,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onCameraMove: ((_position) => _updatePosition(_position)),
        onCameraIdle: onCameraIdle,
      ),
    );
  }

  void onCameraIdle() {
    getUserLocation();
  }

  void _updatePosition(CameraPosition _position) {
    final MarkerId markerId = MarkerId("443");
    Position newMarkerPosition = Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude);
    Marker marker = new Marker(
        markerId: markerId,
        position:
            LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
    setState(() {
      markersSet.removeWhere((element) => element.markerId == MarkerId("443"));
      markersSet.add(marker.copyWith(
          positionParam:
              LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude)));
    });
  }

  void createMarker() {
    if (nearbyIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(1, 1));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration,
              (Platform.isIOS)
                  ? 'assets/images/car_ios.png'
                  : 'assets/images/car_android.png')
          .then((icon) {
        nearbyIcon = icon;
      });
    }
  }

  resetApp() {
    print("reset");
    appState = 'NORMAL';
    availableDrivers.clear();
    FireHelper.nearbyDriverList.clear();
    Geofire.queryAtLocation(
            currentPosition.latitude, currentPosition.longitude, 20)
        .listen((map) {
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyDriver nearbyDriver = NearbyDriver();
            nearbyDriver.key = map['key'];
            print("entered key = " + nearbyDriver.key.toString());
            nearbyDriver.latitude = map['latitude'];
            nearbyDriver.longitude = map['longitude'];
            FireHelper.nearbyDriverList.add(nearbyDriver);

            if (nearbyDriversKeysLoaded) {
              updateDriversOnMap();
            }
            break;

          case Geofire.onKeyExited:
            FireHelper.removeFromList(map['key']);
            updateDriversOnMap();
            break;
          case Geofire.onKeyMoved:
            // Update your key's location

            NearbyDriver nearbyDriver = NearbyDriver();
            nearbyDriver.key = map['key'];
            nearbyDriver.latitude = map['latitude'];
            nearbyDriver.longitude = map['longitude'];

            FireHelper.updateNearbyLocation(nearbyDriver);
            updateDriversOnMap();
            break;

          case Geofire.onGeoQueryReady:
            nearbyDriversKeysLoaded = true;
            updateDriversOnMap();
            break;
        }
      }
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    List<String> _fragilite = ['Tres Fragile', 'Fragile', 'Solide'];
    List<String> _dimensions = [
      'Petite Taille (1)',
      'Moyenne Taille (2)',
      'Grande Taille (3)',
    ];
    final node = FocusScope.of(context);
    return new AlertDialog(
      content: Container(
        child: SingleChildScrollView(
          child: new Column(
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
                    Navigator.of(context).pop();
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
                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: screenwidth * 0.6,
                      child: DropdownButtonFormField<String>(
                        decoration: CommonSyles.textDecoration(
                            context, "Dimensions", null),
                        value: selecteddimension,
                        onChanged: (String value) {
                          setState(() {
                            selecteddimension = value;
                            print(selecteddimension);
                          });
                        },
                        items: _dimensions.map((dimension) {
                          return DropdownMenuItem(
                            child: new Text(dimension),
                            value: dimension,
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
                  ],
                ),
              ),
              SizedBox(
                height: screenheigh * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 6.0),
                child: Container(
                    child: Text(
                        "(1) se transporte par moto*\n(2) se transporte par voiture*\n(3) se transporte par camion*")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 6.0, right: 6.0),
                child: Container(
                  child: TextFormField(
                    onEditingComplete: () => node.nextFocus(),
                    textInputAction: TextInputAction.next,
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
                        "poids",
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
                  child: TextFormField(
                    onEditingComplete: () => node.unfocus(),
                    textInputAction: TextInputAction.done,
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
                      onPressed: () async {
                        var provider = Provider.of<CommandeProvider>(context,
                            listen: false);
                        provider.changedimension(selecteddimension);
                        print("poids = " + poids.toString());
                        provider.changepoids(double.parse(poids.text));
                        provider.changevaleur(double.parse(value.text));
                        print(selectedUser);
                        provider.changefragilite(selectedUser);
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      color: blue,
                      child: Text("Confirmer",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialogdestinataire(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    final node = FocusScope.of(context);

    return new AlertDialog(
      content: SingleChildScrollView(
        child: Column(
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
                child: Text(
                    'Veillez introduire les informations du destinataire',
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
                child: TextFormField(
                  onEditingComplete: () => node.nextFocus(),
                  textInputAction: TextInputAction.next,
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
                child: TextFormField(
                  onEditingComplete: () => node.nextFocus(),
                  textInputAction: TextInputAction.next,
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
                child: TextFormField(
                  onEditingComplete: () => node.unfocus(),
                  textInputAction: TextInputAction.done,
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
                      var provider =
                          Provider.of<CommandeProvider>(context, listen: false);
                      provider.changenomdest(nom.text);
                      provider.changeprenomdest(prenom.text);
                      provider.changeteldest(telephone.text);
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
          FlatButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage())),
            child: ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
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
            ),
          ),
          SizedBox(height: screenheigh * 0.02),
          FlatButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Historique())),
            child: ListTile(
              trailing: Container(
                width: ResponsiveFlutter.of(context).fontSize(3.2),
                child: Center(
                    child: Text(
                        Provider.of<AuthProvider>(context).client.enCours > 0
                            ? "●"
                            : "",
                        style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(2.8),
                          color: Colors.blue[700],
                        ))),
              ),
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
            ),
          ),
          SizedBox(height: screenheigh * 0.02),
          FlatButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Promotion())),
            child: ListTile(
              leading: Icon(
                IconsClass.price_tag,
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
            ),
          ),
          SizedBox(height: screenheigh * 0.02),
          FlatButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Parrainage())),
            child: ListTile(
              leading: Icon(
                Icons.group_outlined,
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
            ),
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
