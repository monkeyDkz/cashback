
import 'package:cash_back/logIn/FirstScreen.dart';
import 'package:cash_back/modules/Layout/HomeLayout.dart';
import 'package:cash_back/modules/Layout/RemboursementSteps.dart';
import 'package:cash_back/modules/basic_screens/HomeScreen.dart';
import 'package:cash_back/modules/others/ProductDescreptionSceen.dart';
import 'package:cash_back/remboursement/ImageStepScreen.dart';

import 'package:cash_back/shared/colors.dart';
import 'package:cash_back/shared/network/local/cash_helper.dart';
import 'package:cash_back/shared/network/remote/dio_helper.dart';
import 'package:cash_back/test/HomeScreen1.dart';
import 'package:cash_back/test/HomeScreenTest.dart';
import 'package:cash_back/test/test1.dart';

import 'package:flutter/material.dart';

import 'ScannerScreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init(
      _scaffoldKey
  );
  await CashHelper.init();
  runApp( MyApp());
}
final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
   const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: mainColor,
      ),
      home:  FirstScreen(),
    );
  }
}