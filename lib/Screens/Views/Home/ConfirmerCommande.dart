import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Models/DirectionDetails.dart';
import 'package:ziouanexpress/Provider/commande.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Components/icons_class.dart';
import 'package:location/location.dart';
import 'package:ziouanexpress/Services/Maps.dart';

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
  GoogleMapController _controller;
  Location _location = Location();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController _cntlr) async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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
    _locationData = await _location.getLocation();
    LatLng latlngposition =
        LatLng(_locationData.latitude, _locationData.longitude);
    CameraPosition cameraposition =
        new CameraPosition(target: latlngposition, zoom: 14);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
    await createpolyline(_cntlr);
  }

  Future<void> createpolyline(GoogleMapController _cntlr) async {
    var provider = Provider.of<CommandeProvider>(context, listen: false);

    DirectionDetails directionDetails = await Maps.obtainPlaceDirectionsDetails(
        context, provider.locationexp, provider.locationdes);
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(directionDetails.encodedPoints);
    print(decodedPolyLinePointsResult.first.toString());
    pLineCoordinates.clear();
    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polylineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
          color: Colors.green,
          polylineId: PolylineId("PolylineID"),
          jointType: JointType.round,
          points: pLineCoordinates,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      polylineSet.add(polyline);
    });

    this.adjustcamera(_cntlr);

    Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: pLineCoordinates.first,
        markerId: MarkerId("expediteur"));

    Marker dropOffLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: pLineCoordinates.last,
        markerId: MarkerId("destinataire"));

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });
    return markersSet;
  }

  void adjustcamera(GoogleMapController _cntlr) {
    LatLngBounds latLngBoundst;
    if (pLineCoordinates.first.latitude > pLineCoordinates.last.latitude &&
        pLineCoordinates.first.longitude > pLineCoordinates.last.longitude) {
      latLngBoundst = LatLngBounds(
          southwest: pLineCoordinates.last, northeast: pLineCoordinates.first);
    } else if (pLineCoordinates.first.longitude >
        pLineCoordinates.last.longitude) {
      latLngBoundst = LatLngBounds(
          southwest: LatLng(
              pLineCoordinates.first.latitude, pLineCoordinates.last.longitude),
          northeast: LatLng(pLineCoordinates.last.latitude,
              pLineCoordinates.first.longitude));
    } else if (pLineCoordinates.first.latitude >
        pLineCoordinates.last.latitude) {
      latLngBoundst = LatLngBounds(
          southwest: LatLng(
              pLineCoordinates.last.latitude, pLineCoordinates.first.longitude),
          northeast: LatLng(pLineCoordinates.first.latitude,
              pLineCoordinates.last.longitude));
    } else {
      latLngBoundst = LatLngBounds(
          southwest: pLineCoordinates.first, northeast: pLineCoordinates.last);
    }
    _controller = _cntlr;
    _controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBoundst, 40));
  }

  LatLng _initialcameraposition = LatLng(36.7525, 3.04197);
  @override
  Widget build(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<CommandeProvider>(context);
    TextEditingController locationexp =
        TextEditingController(text: provider.locationexp);
    TextEditingController locationdes =
        TextEditingController(text: provider.locationdes);
    TextEditingController dimension =
        TextEditingController(text: "Moyenne Taille");
    TextEditingController poids = TextEditingController(text: "12.5 kg");
    TextEditingController valeur = TextEditingController(text: "15000");
    TextEditingController fragilite = TextEditingController(text: "Solide");
    TextEditingController destinataire =
        TextEditingController(text: "Yessad Samy");
    TextEditingController telephone = TextEditingController(text: "0561403441");
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: screenheigh * 0.4,
              child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initialcameraposition),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                zoomControlsEnabled: false,
                polylines: polylineSet,
                markers: markersSet,
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
                top: screenheigh * 0.4,
                child: Container(
                  height: screenheigh * 0.6,
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
                            flex: 4,
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
                                              controller: locationexp,
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
                                              controller: locationdes,
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
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              left: 16.0,
                                              right: 16.0,
                                              bottom: 13),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                              controller: destinataire,
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
                                                      "Destinataire",
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
                                              controller: telephone,
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
                              flex: 3,
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
                                                    .fontSize(3),
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
                                              right: 25, top: 10),
                                          child: Text("-25%",
                                              style: TextStyle(
                                                color: red,
                                                fontFamily: "Nunito",
                                                fontWeight: FontWeight.bold,
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(3),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenheigh * 0.005,
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
