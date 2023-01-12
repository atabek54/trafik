import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:trafik/core/models/city_model.dart';
import 'package:trafik/products/widgets/login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const LoginFormWidget();
  }
}
