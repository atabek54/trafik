import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafik/core/services/api_service.dart';
import 'package:uuid/uuid.dart';

import '../../products/variables/user_info.dart';
import '../models/user_model.dart';

class AuthService {
  static Future<void> register(
      String nameSurname, String phone, String plateNumber) async {
    final uuid = Uuid().v1();
    final data = {
      "operation_type": "insert",  
      "service_type": "register",    
      "name": nameSurname,
      "plaka": plateNumber,
      "phone": phone,
      "uuid": uuid.toString()
    };
    final response = await Dio().post(ApiService.api, data: data);
    if (response.statusCode == HttpStatus.OK) {
      final _datas = jsonDecode(response.data);
     
      if (_datas is List) {
        if (_datas[0] != "Kullanıcı kayıtlı") {
          UserInfo.user = _datas.map((e) => UserModel.fromJson(e)).toList();
          
          sharedPreference(jsonEncode(UserInfo.user?[0]));
        }
      }
    }
  }

  static Future<void> login(
    String phone,
  ) async {
    final data = {
      "operation_type": "select",
      "service_type": "login",
      "phone": phone
    };
    final response = await Dio().post(ApiService.api, data: data);
    if (response.statusCode == HttpStatus.OK) {
      final _datas = jsonDecode(response.data);

      if (_datas is List) {
        if (_datas[0] != "Kullanıcı kayıtlı değil") {
          UserInfo.user = _datas.map((e) => UserModel.fromJson(e)).toList();
          sharedPreference(jsonEncode(UserInfo.user?[0]));

        }
      }
    }
  }

  static Future<void> sharedPreference(value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(value));
    String? userPref = json.decode(prefs.getString('user')!);

  }

  static Future<void> checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userPref = json.decode(prefs.getString('user')!);
    print(userPref);
    if (userPref != null) {
      UserInfo.user = [UserModel.fromJson(jsonDecode(userPref))];
    
    }
  }
}
