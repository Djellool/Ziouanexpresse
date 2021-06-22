import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Components/icons_class.dart';
import 'package:ziouanexpress/Services/ApiCalls.dart';

class HistoriqueDetail extends StatelessWidget {
  final int idLivraison;
  HistoriqueDetail(this.idLivraison);

  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color orange = Color(0xFFF28322);
  final Color blue = Color(0xFF382B8C);
  final Color grey2 = Color(0xFF646464);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: Future.wait([
            ApiCalls().getHistoriqueDetail(
                Provider.of<AuthProvider>(context).token, this.idLivraison),
            ApiCalls().getColisExt(
                Provider.of<AuthProvider>(context).token, this.idLivraison)
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data[1].poids.toString());
              return Scaffold(
                appBar: CommonSyles.appbar(context, "Détails de livraison"),
                body: Container(
                  width: ResponsiveFlutter.of(context).wp(100),
                  child: Column(children: [
                    avatar(context,
                        snapshot.data[0].nom + snapshot.data[0].prenom),
                    date(context, snapshot.data[0].createdAt),
                    ratingbar(context, snapshot.data[0].note),
                    cout(
                        context,
                        snapshot.data[0].prix.toString(),
                        snapshot.data[1].dimensions,
                        snapshot.data[1].fragilite,
                        snapshot.data[1].valeur.toString(),
                        snapshot.data[1].poids.toString()),
                    destination(context, "A traiter", "A traiter")
                  ]),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return SpinKitFadingCube(
              color: violet,
            );
          }),
    );
  }

  Widget avatar(BuildContext context, String nomPrenom) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(20)),
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: Color(0xFF382B8C),
              radius: ResponsiveFlutter.of(context).scale(45),
              child: CircleAvatar(
                backgroundColor: white,
                radius: ResponsiveFlutter.of(context).scale(43),
                backgroundImage: AssetImage("assets/images/avatar.png"),
              )),
          Text(
            nomPrenom,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: violet,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveFlutter.of(context).fontSize(4)),
          )
        ],
      ),
    );
  }

  Widget date(BuildContext context, String date) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ResponsiveFlutter.of(context).scale(24)),
      child: Text(
        DateFormat.yMMMEd('fr').format(DateTime.parse(date)).toString() +
            " à " +
            DateFormat('HH:mm').format(DateTime.parse(date)),
        style: TextStyle(
            color: violet,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveFlutter.of(context).fontSize(3)),
      ),
    );
  }

  Widget ratingbar(context, double note) {
    return RatingBar(
      itemSize: ResponsiveFlutter.of(context).fontSize(4.5),
      initialRating: note,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full:
            Image(color: violet, image: AssetImage('assets/images/heart.png')),
        half: Image(
            color: violet, image: AssetImage('assets/images/heart_half.png')),
        empty: Image(
            color: violet, image: AssetImage('assets/images/heart_border.png')),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {},
    );
  }

  Widget cout(context, String prix, String dimension, String fragilite,
      String valeur, String poids) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(24)),
      width: ResponsiveFlutter.of(context).wp(90),
      height: ResponsiveFlutter.of(context).hp(16),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Cout de livraison",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: grey2,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(3),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  prix + " DA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: violet,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: FlatButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => _buildPopupDialog(
                          context, dimension, fragilite, valeur, poids));
                },
                color: violet,
                height: ResponsiveFlutter.of(context).hp(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: violet,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: Icon(
                    IconsClass.package,
                    size: ResponsiveFlutter.of(context).fontSize(4),
                    color: white,
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget destination(context, String pickup, String dropoff) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(16)),
      width: ResponsiveFlutter.of(context).wp(90),
      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
      child: Row(
        children: [
          SizedBox(
            width: ResponsiveFlutter.of(context).wp(15),
            child: Column(
              children: [
                CircleAvatar(
                  radius: ResponsiveFlutter.of(context).scale(12),
                  backgroundColor: violet,
                  child: CircleAvatar(
                    backgroundColor: white,
                    radius: ResponsiveFlutter.of(context).scale(8),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  height: ResponsiveFlutter.of(context).hp(6),
                  child: VerticalDivider(
                    thickness: 3,
                    color: grey2,
                    indent: 3,
                    endIndent: 3,
                  ),
                ),
                CircleAvatar(
                  radius: ResponsiveFlutter.of(context).scale(12),
                  backgroundColor: orange,
                  child: CircleAvatar(
                    backgroundColor: white,
                    radius: ResponsiveFlutter.of(context).scale(8),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pickup,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: violet,
                        fontFamily: "Nunito",
                        fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                      ),
                    ),
                    Text(
                      "à 5min",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: grey2,
                        fontFamily: "Nunito",
                        fontSize: ResponsiveFlutter.of(context).fontSize(2),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Chemin de Ziouane, Kouba, Alger ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: grey2,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  ),
                ),
                Container(
                    child: Divider(
                  thickness: 2,
                  color: grey2,
                  endIndent: ResponsiveFlutter.of(context).scale(15),
                )),
                Text(
                  dropoff,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: orange,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                  ),
                ),
                Text(
                  "Chemin de Ziouane, Hydra, Alger ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: grey2,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, String dimension,
      String fragilite, String valeur, String poids) {
    var screenheigh = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return new AlertDialog(
      title: Center(
          child: Text("Détails du colis",
              style: TextStyle(
                  color: violet,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w600,
                  fontSize: ResponsiveFlutter.of(context).fontSize(3.5)))),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenwidth * 0.6,
                    child: TextFormField(
                      decoration: CommonSyles.textDecoration(
                          context, "Dimensions", null),
                      readOnly: true,
                      initialValue: dimension,
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
              padding: const EdgeInsets.only(top: 15, left: 6.0, right: 6.0),
              child: Container(
                child: TextFormField(
                  initialValue: poids,
                  readOnly: true,
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
                  initialValue: valeur,
                  style: TextStyle(
                      color: grey2,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2),
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
                child: TextFormField(
                  initialValue: fragilite,
                  decoration:
                      CommonSyles.textDecoration(context, "Fragilite", null),
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
          ],
        ),
      ),
    );
  }
}
