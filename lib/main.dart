import 'package:bill_app/pages/bill-screen.dart';
import 'package:bill_app/pages/splash-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/Products_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //
  // await Firebase.initializeApp(
  //     // options: DefaultFirebaseOptions.currentPlatform,
  //     );
  runApp(const MyApp());
  // Khóa xoay màn hình
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Products(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sala Beauty',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const TimerPage()
          // routes: {
          //   DetailProductPage.routerName: (context) =>  DetailProductPage()
          // }
          ),
    );
  }
}
