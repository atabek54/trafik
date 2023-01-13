import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trafik/pages/login_page.dart';
import 'package:trafik/pages/map_view.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color.fromARGB(255, 25, 38, 134), secondary: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        buttonColor: Colors.black,
        buttonTheme: ButtonThemeData(buttonColor: Colors.black),
        textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      home: GoogleMapScreen(),
    );
  }
}
