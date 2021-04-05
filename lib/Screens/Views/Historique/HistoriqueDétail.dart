import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';

class HistoriqueDetail extends StatelessWidget {
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color orange = Color(0xFFF28322);
  final Color blue = Color(0xFF382B8C);
  final Color grey2 = Color(0xFF646464);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonSyles.appbar(context, "Détails de livraison"),
        body: Container(
          width: ResponsiveFlutter.of(context).wp(100),
          child: Column(children: [
            avatar(context),
            date(context),
            ratingbar(context, 2),
            cout(context, "540"),
            destination(context, "Kouba", "Hydra")
          ]),
        ),
      ),
    );
  }

  Widget avatar(BuildContext context) {
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
            "Yessad Samy",
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

  Widget date(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ResponsiveFlutter.of(context).scale(24)),
      child: Text(
        "Mercredi 10-01-2021 à 11:32",
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

  Widget cout(context, String prix) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(24)),
      width: ResponsiveFlutter.of(context).wp(90),
      height: ResponsiveFlutter.of(context).hp(18),
      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(10)),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
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
}
