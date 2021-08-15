import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Views/Historique/HistoriqueD%C3%A9tail.dart';
import 'package:ziouanexpress/Services/ApiCalls.dart';

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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);

    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: CommonSyles.appbar(context, "Historique"),
      body: FutureBuilder(
        future:
            ApiCalls().getHistorique(provider.token, provider.client.idClient),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView.separated(
                itemBuilder: (context, int index) {
                  return ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoriqueDetail(
                                snapshot.data[index].idLivraisonExterne))),
                    visualDensity: VisualDensity.comfortable,
                    tileColor: snapshot.data[index].etat == 'en cours'
                        ? Colors.blue[50]
                        : null,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    leading: avatar(context),
                    title: Text(
                      snapshot.data[index] != null
                          ? snapshot.data[index].prenom
                          : "",
                      style: TextStyle(
                          color: violet,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveFlutter.of(context).fontSize(3)),
                    ),
                    subtitle: Text(
                      DateFormat('yMMMEd', 'fr')
                              .format(DateTime.parse(
                                  snapshot.data[index].createdAt))
                              .toString() +
                          " à " +
                          DateFormat('HH:mm').format(
                              DateTime.parse(snapshot.data[index].createdAt)),
                      style: TextStyle(
                          color: violet,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                    ),
                    trailing: Text(
                      snapshot.data[index].prix.toString() + " DA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: orange,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveFlutter.of(context).fontSize(3)),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: snapshot.data.length,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Une erreur s'est produite"),
            );
          }
          return Center(
              child: SpinKitFadingCube(
            color: violet,
          ));
        },
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
