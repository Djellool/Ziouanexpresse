import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Provider/GeneralProvider.dart';
import 'package:ziouanexpress/Screens/Views/Login-Inscription/LoginScreen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<GeneralProvider>(create: (_) => GeneralProvider()),
  ], child: ZeClient()));
}

class ZeClient extends StatelessWidget {
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
                  return LoginScreen();
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
