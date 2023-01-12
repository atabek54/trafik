import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';
import 'package:trafik/core/services/auth_service.dart';
import 'package:trafik/pages/homepage.dart';

import 'package:trafik/products/paddings/padding.dart';
import 'package:trafik/products/texts/text.dart';
import 'package:trafik/products/variables/user_info.dart';

import '../../core/services/main_service.dart';
import 'global_button.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool? _isLoading = false;
  bool? _isLogin = false;
  String? _nameSurname;
  String? _phone;
  String? _numberPlate;
  List? user;

  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    await AuthService.checkUser();
    if (jsonEncode(UserInfo.user) != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: _isLoading == true
          ? CircularProgressIndicator.adaptive()
          : Padding(
              padding: Paddings.globalPadding,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: Paddings.loginHeader,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _isLogin == true
                              ? Texts.loginHeader
                              : Texts.registerHeader,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                    _empty(40),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        Texts.loginDescription,
                        style: TextStyle(
                            color: Color.fromARGB(255, 62, 63, 62),
                            letterSpacing: 1.2,
                            fontSize: 16.0,
                            height: 1.3),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _empty(50),
                    if (_isLogin == false)
                      TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: Texts.textform1,
                            hintText: Texts.textform1,
                          ),
                          onChanged: (value) => setState(() {
                                _nameSurname = value;
                              })),
                    _empty(20),
                    TextFormField(
                        scrollPadding: EdgeInsets.only(bottom: 40),
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: Texts.textform2,
                          hintText: "(5** *** ** **)",
                        ),
                        onChanged: (value) => setState(() {
                              _phone = value;
                            })),
                    _empty(20),
                    if (_isLogin == false)
                      TextFormField(
                        onChanged: (value) => setState(() {
                          _numberPlate = value;
                        }),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: Texts.textform3,
                          hintText: Texts.textform3,
                        ),
                      ),
                    _empty(20),
                    GlobalButtonWidget(
                      loginButtonOnPressed: (() async => {
                            _isLoading = true,
                            EasyLoading.show(status: Texts.easyloadingWait),
                            if (_isLogin == false)
                              {
                                await AuthService.register(
                                        _nameSurname!, _phone!, _numberPlate!)
                                    as List?,
                                print(UserInfo.user?[0]),
                                if (UserInfo.user?[0] != null)
                                  {
                                    EasyLoading.showSuccess(Texts.easyloadingSuccessRegister),
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(),fullscreenDialog: true))
                                  }
                                else
                                  {
                                    EasyLoading.showError(
                                        Texts.easyloadingErrorRegister)
                                  },
                                await Future.delayed(
                                    const Duration(seconds: 2), () => {}),
                              }
                            else
                              {
                                await AuthService.login(_phone!) as List?,
                                print(UserInfo.user?[0]),
                                if (UserInfo.user?[0] != null)
                                  {
                                    EasyLoading.showSuccess(Texts.easyloadingSuccessLogin),
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()))
                                  }
                                else
                                  {
                                    EasyLoading.showError(
                                        Texts.easyloadingErrorLogin)
                                  },
                                await Future.delayed(
                                    const Duration(seconds: 2), () => {}),
                              },
                            _isLoading = false,
                            EasyLoading.dismiss(),
                          }),
                      text: _isLogin == true
                          ? Texts.elevatedButtonLogin
                          : Texts.elevatedButtonRegister,
                    ),
                    _empty(20),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin!;
                            print(_isLogin);
                          });
                        },
                        child: Text(
                          _isLogin == true
                              ? Texts.textRegister
                              : Texts.textLogin,
                          style: TextsStyles.textLoginRegister,
                        ))
                  ],
                ),
              ),
            ),
    ));
  }

  static SizedBox _empty(double empty) => SizedBox(
        height: empty,
      );
}
