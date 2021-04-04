import 'package:flutter/material.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';

class Historique extends StatefulWidget {
  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
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
      body: ListView.separated(
          itemBuilder: (context, int index) {
            return ListTile(
              title: Text(drivers[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: drivers.length),
    ));
  }
}
