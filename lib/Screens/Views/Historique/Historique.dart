import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';

class Historique extends StatefulWidget {
  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color orange = Color(0xFFF28322);
  final Color blue = Color(0xFF382B8C);
  final Color grey2 = Color(0xFF646464);
  List drivers = [
    "Yessad Samy mohamed",
    "Naila",
    "djilali",
    "chiraze",
    "Amine",
    "Selmane"
  ];
  List prices = ["510", "520", "630", "780", "850", "410"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CommonSyles.appbar(context, "Historique"),
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(
                  drivers[index],
                  style: TextStyle(
                      color: violet,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: drivers.length),
      ),
    ));
  }
}
