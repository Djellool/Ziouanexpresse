import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Provider/GeneralProvider.dart';
import 'package:ziouanexpress/Provider/InscriptionProvider.dart';
import 'package:ziouanexpress/Provider/commande.dart';
import 'package:ziouanexpress/Screens/Views/Home/HomePage.dart';
import 'package:ziouanexpress/Screens/Views/Login-Inscription/LoginScreen.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<GeneralProvider>(create: (_) => GeneralProvider()),
    ChangeNotifierProvider<CommandeProvider>(create: (_) => CommandeProvider()),
    ChangeNotifierProvider<InscriptionProvider>(
        create: (_) => InscriptionProvider())
  ], child: ZeClient()));
}

class ZeClient extends StatefulWidget {
  @override
  _ZeClientState createState() => _ZeClientState();
}

class _ZeClientState extends State<ZeClient> {
  // This widget is the root of your application.
  //

  final storage = new FlutterSecureStorage();

  Future<void> readToken() async {
    String token = await storage.read(key: "token");
    await Provider.of<AuthProvider>(context, listen: false)
        .tryToken(context, token);
    print("token : $token");
  }

  @override
  void initState() {
    initializeDateFormatting();
    readToken();
    super.initState();
  }

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
              case "loggedIN":
                {
                  return HomePage();
                }
            }
            return Container();
          },
        )),
      ),
      builder: EasyLoading.init(),
    );
  }
}
