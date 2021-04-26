import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Screens/Components/CommunStyles.dart';
import 'package:ziouanexpress/Screens/Views/Profile/ProfilePassword.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  launchURL() async {
    const url = 'tel:+213771854123';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    final provider = Provider.of<AuthProvider>(context, listen: false).client;
    super.initState();
    _nomController = TextEditingController(text: provider.nom);
    _prenomController = TextEditingController(text: provider.prenom);
    _emailController = TextEditingController(text: provider.email);
    _phoneController = TextEditingController(text: provider.telephone);
  }

  bool changed = false;

  TextEditingController _nomController;
  TextEditingController _prenomController;
  TextEditingController _phoneController;
  TextEditingController _emailController;

  final _formKey = GlobalKey<FormState>();

  final Color background = Color(0xFFF2F2F2);
  final Color orange = Color(0xFFF28322);
  final Color violet = Color(0xFF382B8C);
  final Color white = Colors.white;
  final Color grey = Color(0xFFC4C4C4);
  final Color grey2 = Color(0xFF646464);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        appBar: CommonSyles.appbar(context, "Profile"),
        backgroundColor: white,
        body: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              child: Container(
                height: ResponsiveFlutter.of(context).hp(89),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        avatar(context),
                        namefield(context, node),
                        prenomfield(context, node),
                        phonefield(
                          context,
                          node,
                        ),
                        emailfield(
                          context,
                          node,
                        ),
                        button(context, node),
                      ],
                    ),
                    commandes(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget avatar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
      child: CircleAvatar(
          backgroundColor: Color(0xFF382B8C),
          radius: ResponsiveFlutter.of(context).scale(35),
          child: CircleAvatar(
            backgroundColor: white,
            radius: ResponsiveFlutter.of(context).scale(33),
            backgroundImage: AssetImage("assets/images/avatar.png"),
          )),
    );
  }

  Widget namefield(BuildContext context, FocusNode node) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 08, left: 16.0, right: 16.0, bottom: 8),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.nextFocus(),
          textInputAction: TextInputAction.next,
          controller: _nomController,
          cursorColor: grey2,
          keyboardType: TextInputType.name,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
          decoration: CommonSyles.textDecoration(context, "Nom", null),
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
    );
  }

  Widget prenomfield(
    BuildContext context,
    FocusNode node,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.nextFocus(),
          textInputAction: TextInputAction.next,
          controller: _prenomController,
          cursorColor: grey2,
          keyboardType: TextInputType.name,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
          decoration: CommonSyles.textDecoration(context, "Prenom", null),
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
    );
  }

  Widget emailfield(BuildContext context, FocusNode node) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.unfocus(),
          textInputAction: TextInputAction.done,
          controller: _emailController,
          cursorColor: grey2,
          validator: (value) => _emailValidation(value),
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
          decoration: CommonSyles.textDecoration(context, "Adresse mail", null),
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
    );
  }

  Widget phonefield(
    BuildContext context,
    FocusNode node,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
      child: Container(
        child: TextFormField(
          onEditingComplete: () => node.nextFocus(),
          textInputAction: TextInputAction.next,
          controller: _phoneController,
          cursorColor: grey2,
          keyboardType: TextInputType.phone,
          style: TextStyle(
              letterSpacing: 01,
              color: grey2,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
          decoration:
              CommonSyles.textDecoration(context, "Numéro de téléphone", null),
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
    );
  }

  String _emailValidation(String value) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (!emailValid) {
      return "Veuillez entrez une adresse mail valide";
    } else {
      return null;
    }
  }

  Widget button(BuildContext context, FocusNode node) {
    return Container(
      height: ResponsiveFlutter.of(context).hp(8),
      width: ResponsiveFlutter.of(context).wp(60),
      decoration: BoxDecoration(
        color: violet,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      child: FlatButton(
        onPressed: () {
          node.unfocus();
        },
        child: Text(
          "Sauvegarder",
          style: TextStyle(
              color: white,
              fontFamily: "Nunito",
              fontSize: ResponsiveFlutter.of(context).fontSize(3)),
        ),
      ),
    );
  }

  Widget commandes(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfilePassword()));
              },
              child: CommonSyles.rows("Changer le mot de passe",
                  Icons.lock_open_rounded, context, violet)),
          FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: null,
              child: CommonSyles.rows("Conditions d'utilisation",
                  Icons.rule_folder_outlined, context, violet)),
          FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: launchURL,
              child: CommonSyles.rows("Centre d'appel",
                  Icons.phone_in_talk_outlined, context, violet)),
          FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () async {
                await Provider.of<AuthProvider>(context, listen: false)
                    .logout();
                Navigator.pop(context);
              },
              child: CommonSyles.rows(
                  "Déconnexion", Icons.logout, context, orange)),
        ],
      ),
    );
  }
}
