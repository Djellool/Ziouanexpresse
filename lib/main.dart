import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Provider/GeneralProvider.dart';
import 'package:ziouanexpress/Provider/InscriptionProvider.dart';
import 'package:ziouanexpress/Provider/commande.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ziouanexpress/Screens/Views/Home/HomePage.dart';
import 'package:ziouanexpress/Screens/Views/Login-Inscription/LoginScreen.dart';

import 'Assistants/globalvariables.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<GeneralProvider>(create: (_) => GeneralProvider()),
    ChangeNotifierProvider<CommandeProvider>(create: (_) => CommandeProvider()),
    ChangeNotifierProvider<InscriptionProvider>(
        create: (_) => InscriptionProvider())
  ], child: ZeClient()));
}

class ZeClient extends StatelessWidget {
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(body: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            switch (auth.authenticated) {
              case "loggedout":
                {
                  return HomePage();
                }
                break;
            }
            return Container();
          },
        )),
      ),
    );
  }
}
