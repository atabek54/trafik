import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:trafik/pages/login_page.dart';
import 'package:trafik/products/texts/text.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      title: Text(
        Texts.splashTitle,
        style: GoogleFonts.quicksand(fontSize: 42, letterSpacing: 2),
      ),
      image: Image.asset("assets/images/trafik.png"),
      styleTextUnderTheLoader: TextStyle(fontSize: 2),
      photoSize: Sizes.photoSize,
      useLoader: false,
      navigateAfterSeconds:  LoginPage(),
      loadingText: Text(Texts.loadingText
        ,
        style: TextsStyles.splashLoadingText
      ),
      loaderColor: Colors.black,
      gradientBackground: CustomColor.warningCardColor,
    );
  }
}
