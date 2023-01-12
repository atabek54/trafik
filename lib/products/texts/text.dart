import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Texts {
  static const splashTitle="Yol İkaz";
  //Login Screen Text
  static const loginHeader = "Giriş";
  static const registerHeader = "Kayıt";

  static const loginDescription =
      "Güzergahındaki radarları görüntüle, trafikteki durumu öğren ve güvenli yolculuk yap.";
  static const textform1 = "Ad Soyad";
  static const textform2 = "Telefon";
  static const textform3 = "Plaka Kodu";
  static const elevatedButtonLogin = "Giriş Yap";
  static const elevatedButtonRegister = "Kaydol";
  static const textLogin = "Hesabın var mı ? Giriş yap";
  static const textRegister = "Hesabın yok mu ? Kaydol";
  //
  static const addModalFormText = "Açıklama";
  static const addButtonText = "Paylaş";
  static const loadingText = "Radar , Kontrol noktası , Trafik kazası";
  //loading texts
  static const easyloadingWait = "yükleniyor...";
  static const easyloadingSuccessRegister = "Kayıt Başarılı";
  static const easyloadingSuccessLogin = "Giriş Başarılı";
  static const easyloadingErrorRegister = "Kullanıcı zaten kayıtlı";
  static const easyloadingErrorLogin = "Kullanıcı bulunamadı";
}

class TextsStyles {
  static const loginHeader = TextStyle(fontFamily: 'Roboto');
  static const elevatedButtonText = TextStyle(
      fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 18);
  static const textLoginRegister = TextStyle(
    color: Colors.black,
    letterSpacing: 1,
    fontSize: 17,
  );
  static final warningCardHeader =
      GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold);

  static final warningCardDesc =
      GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w500);
      static final splashLoadingText =GoogleFonts.quicksand(fontSize: 20);
}

class CustomColor {
  static const LinearGradient warningCardColor = LinearGradient(colors: [
    Colors.orange,
    Color.fromARGB(255, 211, 90, 9),
  ]);
}

class Sizes{
  static final double photoSize = 110.0;
   
}
