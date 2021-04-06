import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Views/Historique/HistoriqueD%C3%A9tail.dart';

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
  List dates = [
    "02-03-2021 à 10:32",
    "02-03-2021 à 10:32",
    "02-03-2021 à 10:32",
    "02-03-2021 à 10:32",
    "02-03-2021 à 10:32",
    "02-03-2021 à 10:32",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: CommonSyles.appbar(context, "Historique"),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.separated(
            itemBuilder: (context, int index) {
              return ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HistoriqueDetail())),
                visualDensity: VisualDensity.comfortable,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                leading: avatar(context),
                title: Text(
                  drivers[index],
                  style: TextStyle(
                      color: violet,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveFlutter.of(context).fontSize(3)),
                ),
                subtitle: Text(
                  dates[index],
                  style: TextStyle(
                      color: violet,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                ),
                trailing: Text(
                  prices[index] + " DA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: orange,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveFlutter.of(context).fontSize(3)),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: drivers.length),
      ),
    ));
  }

  Widget avatar(BuildContext context) {
    return CircleAvatar(
        backgroundColor: violet,
        radius: ResponsiveFlutter.of(context).scale(30),
        child: CircleAvatar(
          backgroundColor: white,
          radius: ResponsiveFlutter.of(context).scale(24),
          backgroundImage: AssetImage("assets/images/avatar.png"),
        ));
  }
}
