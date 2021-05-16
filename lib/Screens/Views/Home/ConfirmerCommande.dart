import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Assistants/HelperMethods.dart';
import 'package:ziouanexpress/Assistants/firehelper.dart';
import 'package:ziouanexpress/Assistants/globalvariables.dart';
import 'package:ziouanexpress/Assistants/rideVaribles.dart';
import 'package:ziouanexpress/Models/DirectionDetails.dart';
import 'package:ziouanexpress/Models/Nearbydriver.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Provider/commande.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Components/icons_class.dart';
import 'package:location/location.dart';
import 'package:ziouanexpress/Services/ApiCalls.dart';
import 'package:ziouanexpress/Services/Maps.dart';
import 'package:ziouanexpress/Models/Promotion.dart';

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
  String prix = price.toStringAsFixed(0);
  double prixavecpromo = price;
  DatabaseReference rideRef;
  StreamSubscription<Event> rideSubscription;

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
    Geofire.initialize('driversAvailable');
    startListening(LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  Future<void> createpolyline(GoogleMapController _cntlr) async {
    var provider = Provider.of<CommandeProvider>(context, listen: false);

    DirectionDetails directionDetails = await Maps.obtainPlaceDirectionsDetails(
        context, provider.locationexp, provider.locationdes);
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(directionDetails.encodedPoints);
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
    _controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBoundst, 80));
  }

  LatLng _initialcameraposition = LatLng(36.7525, 3.04197);
  List<Promotions> promotions = [];
  List<NearbyDriver> availableDrivers;
  String appState = 'NORMAL';
  void commander() {
    appState = "REQUESTING";
    availableDrivers = FireHelper.nearbyDriverList;
    findDriver();
  }

  void startListening(LatLng currentPosition) {
    print("Before length :" + FireHelper.nearbyDriverList.length.toString());
    Geofire.queryAtLocation(
            currentPosition.latitude, currentPosition.longitude, 20)
        .listen((map) {
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyDriver nearbyDriver = NearbyDriver();
            nearbyDriver.key = map['key'];
            nearbyDriver.latitude = map['latitude'];
            nearbyDriver.longitude = map['longitude'];
            if (FireHelper.contains(map['key']) == true) {
              print(map['key'].toString() + " Contains");
            } else {
              print("Adding");
              FireHelper.nearbyDriverList.add(nearbyDriver);
            }
            break;

          case Geofire.onKeyExited:
            FireHelper.removeFromList(map['key']);
            break;
          case Geofire.onKeyMoved:
            // Update your key's location

            NearbyDriver nearbyDriver = NearbyDriver();
            nearbyDriver.key = map['key'];
            nearbyDriver.latitude = map['latitude'];
            nearbyDriver.longitude = map['longitude'];

            FireHelper.updateNearbyLocation(nearbyDriver);
            break;

          case Geofire.onGeoQueryReady:
            print("after length :" +
                FireHelper.nearbyDriverList.length.toString());
            break;
        }
      }
    });
  }

  void createRideRequest() {
    rideRef = FirebaseDatabase.instance.reference().child('rideRequest').push();

    var provider = Provider.of<CommandeProvider>(context, listen: false);
    var authprovider = Provider.of<AuthProvider>(context, listen: false);
    var pickup = provider.locationexp;
    var destination = provider.locationdes;

    Map rideMap = {
      'created_at': DateTime.now().toString(),
      'rider_name': authprovider.client.nom + " " + authprovider.client.prenom,
      'rider_phone': authprovider.client.telephone,
      'pickup_address': pickup,
      'destination_address': destination,
      'driver_id': 'waiting',
    };

    rideRef.set(rideMap);

    rideSubscription = rideRef.onValue.listen((event) async {
      //check for null snapshot
      if (event.snapshot.value == null) {
        return;
      }

      //get car details
      if (event.snapshot.value['car_details'] != null) {
        setState(() {
          driverCarDetails = event.snapshot.value['car_details'].toString();
        });
      }

      // get driver name
      if (event.snapshot.value['driver_name'] != null) {
        setState(() {
          driverFullName = event.snapshot.value['driver_name'].toString();
        });
      }

      // get driver phone number
      if (event.snapshot.value['driver_phone'] != null) {
        setState(() {
          driverPhoneNumber = event.snapshot.value['driver_phone'].toString();
        });
      }

      //get and use driver location updates
      if (event.snapshot.value['driver_location'] != null) {
        double driverLat = double.parse(
            event.snapshot.value['driver_location']['latitude'].toString());
        double driverLng = double.parse(
            event.snapshot.value['driver_location']['longitude'].toString());
        LatLng driverLocation = LatLng(driverLat, driverLng);

        if (status == 'accepted') {
        } else if (status == 'ontrip') {
        } else if (status == 'arrived') {
          setState(() {
            tripStatusDisplay = 'Driver has arrived';
          });
        }
      }
      if (event.snapshot.value['status'] != null) {
        status = event.snapshot.value['status'].toString();
      }

      if (status == 'accepted') {
        Geofire.stopListener();
        print('accepted');
      }

      if (status == 'ended') {
        if (event.snapshot.value['fares'] != null) {
          int fares = int.parse(event.snapshot.value['fares'].toString());
        }
      }
    });
  }

  void cancelRequest() {
    rideRef.remove();
    setState(() {
      appState = 'NORMAL';
    });
  }

  resetApp() {
    appState = 'NORMAL';
    availableDrivers.clear();
    FireHelper.nearbyDriverList.clear();
    rideRef = null;
    status = '';
    driverFullName = '';
    driverPhoneNumber = '';
    driverCarDetails = '';
    tripStatusDisplay = 'Driver is Arriving';

    Geofire.stopListener();
    Geofire.initialize('driversAvailable');
    startListening(LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  void findDriver() {
    if (availableDrivers.length == 0) {
      print("available drivers = 0");
      resetApp();
      cancelRequest();
      resetApp();
      print("No available drivers");
      return;
    }
    var driver = availableDrivers[0];

    notifyDriver(driver);
    availableDrivers.removeAt(0);
    print("Notified driver :" + driver.key.toString());
  }

  void notifyDriver(NearbyDriver driver) {
    DatabaseReference driverTripRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/${driver.key}/newtrip');
    driverTripRef.set(rideRef.key);
    // Get and notify driver using token
    DatabaseReference tokenRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/${driver.key}/token');

    tokenRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        String token = snapshot.value.toString();
        // send notification to selected driver
        HelperMethods.sendNotification(token, context, rideRef.key);
      } else {
        return;
      }

      const oneSecTick = Duration(seconds: 1);

      var timer = Timer.periodic(oneSecTick, (timer) {
        // stop timer when ride request is cancelled;
        if (appState != 'REQUESTING') {
          driverTripRef.set('cancelled');
          driverTripRef.onDisconnect();
          timer.cancel();
          driverRequestTimeout = 10;
        }
        driverRequestTimeout--;
        // a value event listener for driver accepting trip request
        driverTripRef.onValue.listen((event) {
          // confirms that driver has clicked accepted for the new trip request
          if (event.snapshot.value.toString() == 'accepted') {
            driverTripRef.onDisconnect();
            timer.cancel();
            driverRequestTimeout = 30;
          }
        });

        if (driverRequestTimeout == 0) {
          //informs driver that ride has timed out
          driverTripRef.set('timeout');
          driverTripRef.onDisconnect();
          driverRequestTimeout = 10;
          timer.cancel();

          //select the next closest driver
          findDriver();
        }
      });
    });
  }

  int i = nbpromotions - 1;
  @override
  Widget build(BuildContext context) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    var authprovider = Provider.of<AuthProvider>(context);
    var provider = Provider.of<CommandeProvider>(context);
    TextEditingController locationexp =
        TextEditingController(text: provider.locationexp);
    TextEditingController locationdes =
        TextEditingController(text: provider.locationdes);
    TextEditingController dimension =
        TextEditingController(text: provider.dimension);
    TextEditingController poids =
        TextEditingController(text: provider.poids.toString());
    TextEditingController valeur =
        TextEditingController(text: provider.valeur.toString());
    TextEditingController fragilite =
        TextEditingController(text: provider.fragilite);
    TextEditingController destinataire = TextEditingController(
        text: provider.nomdest + " " + provider.prenomdest);
    TextEditingController telephone =
        TextEditingController(text: provider.teldest);
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
              future: ApiCalls().getPromotions(
                  authprovider.token, authprovider.client.idClient),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (promotions.length == 0) {
                    promotions = snapshot.data;
                    while (i >= 0) {
                      if (promotions[i].utilise == 0 &&
                          (DateTime.now().difference(DateTime.tryParse(
                                  promotions[i].finValidite)) <
                              Duration(days: 1))) {
                        if (promotions[i].valeur <= 1 && prixavecpromo > 0) {
                          prixavecpromo = prixavecpromo -
                              prixavecpromo * promotions[i].valeur;
                          if (prixavecpromo < 0) {
                            prixavecpromo = 0;
                          }
                          print(i.toString() +
                              " " +
                              promotions[i].valeur.toString() +
                              " " +
                              prixavecpromo.toString());
                          promotions[i].utilise = 2;
                        } else {
                          if (promotions[i].valeur > 1 && prixavecpromo > 0) {
                            prixavecpromo =
                                prixavecpromo - promotions[i].valeur;
                            if (prixavecpromo < 0) {
                              prixavecpromo = 0;
                            }
                            print(i.toString() +
                                " " +
                                promotions[i].valeur.toString() +
                                " " +
                                prixavecpromo.toString());
                            promotions[i].utilise = 2;
                          }
                        }
                      }
                      i--;
                    }
                  }
                  return Stack(
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
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                    .fontSize(
                                                                        2),
                                                            fontFamily:
                                                                "Nunito",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        decoration: CommonSyles
                                                            .textDecoration(
                                                                context,
                                                                "Location expediteur",
                                                                Icon(
                                                                  IconsClass
                                                                      .truck,
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                    .fontSize(
                                                                        2),
                                                            fontFamily:
                                                                "Nunito",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        decoration: CommonSyles
                                                            .textDecoration(
                                                                context,
                                                                "Location destinataire",
                                                                Icon(
                                                                  IconsClass
                                                                      .package,
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
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                      .fontSize(
                                                                          2),
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration: CommonSyles
                                                              .textDecoration(
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
                                                            color:
                                                                Colors.black38,
                                                            blurRadius: 25,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                      .fontSize(
                                                                          2),
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration: CommonSyles
                                                              .textDecoration(
                                                                  context,
                                                                  "Poids (KG)",
                                                                  Icon(
                                                                    IconsClass
                                                                        .weight,
                                                                    color: blue,
                                                                    size: 30,
                                                                  ))),
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black38,
                                                            blurRadius: 25,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                      .fontSize(
                                                                          2),
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration: CommonSyles
                                                              .textDecoration(
                                                                  context,
                                                                  "Valeur (DA)",
                                                                  Icon(
                                                                    IconsClass
                                                                        .price_tag,
                                                                    color: blue,
                                                                    size: 30,
                                                                  ))),
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black38,
                                                            blurRadius: 25,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                      .fontSize(
                                                                          2),
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          decoration: CommonSyles
                                                              .textDecoration(
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
                                                            color:
                                                                Colors.black38,
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
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Container(
                                                    child: TextField(
                                                        controller:
                                                            destinataire,
                                                        readOnly: true,
                                                        style: TextStyle(
                                                            color: blue,
                                                            fontSize:
                                                                ResponsiveFlutter.of(
                                                                        context)
                                                                    .fontSize(
                                                                        2),
                                                            fontFamily:
                                                                "Nunito",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        decoration: CommonSyles
                                                            .textDecoration(
                                                                context,
                                                                "Destinataire",
                                                                Icon(
                                                                  Icons
                                                                      .account_circle,
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                    .fontSize(
                                                                        2),
                                                            fontFamily:
                                                                "Nunito",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        decoration: CommonSyles
                                                            .textDecoration(
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
                                              child: Text(
                                                  prix.toString() + " DA",
                                                  style: TextStyle(
                                                      color: grey,
                                                      fontFamily: "Nunito",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .fontSize(3),
                                                      decoration: TextDecoration
                                                          .lineThrough)),
                                            ),
                                            Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      prixavecpromo
                                                              .toStringAsFixed(
                                                                  0) +
                                                          " DA",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: blue,
                                                        fontFamily: "Nunito",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .fontSize(5),
                                                      )),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 25, top: 10),
                                                    child: Text("-25%",
                                                        style: TextStyle(
                                                          color: red,
                                                          fontFamily: "Nunito",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              ResponsiveFlutter
                                                                      .of(context)
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
                                              height:
                                                  ResponsiveFlutter.of(context)
                                                      .hp(7),
                                              width:
                                                  ResponsiveFlutter.of(context)
                                                      .wp(60),
                                              decoration: BoxDecoration(
                                                color: blue,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                              ),
                                              child: FlatButton(
                                                onPressed: () {
                                                  EasyLoading.show();
                                                  setState(() {
                                                    appState = 'REQUESTING';
                                                  });
                                                  availableDrivers = FireHelper
                                                      .nearbyDriverList;
                                                  print(
                                                      "available drivers in Confirmer : " +
                                                          availableDrivers
                                                              .toString());
                                                  createRideRequest();
                                                  findDriver();

                                                  EasyLoading.dismiss();
                                                },
                                                child: Text(
                                                  "Confirmer",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Nunito",
                                                      fontSize:
                                                          ResponsiveFlutter.of(
                                                                  context)
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
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return SpinKitFadingCube(
                  color: blue,
                );
              })),
    );
  }
}
