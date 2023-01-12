import 'dart:ffi';

class UserModel {
  Int? id;
  String? name;
  String? phone;
  String? plaka;
  String? uuid;
  String? sehiradi;

  UserModel(
      {this.id, this.name, this.phone, this.plaka, this.uuid, this.sehiradi});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    id = json[id];
    name = json['name'];
    phone = json['phone'];
    plaka = json['plaka'];
    uuid = json['uuid'];
    sehiradi = json['sehiradi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['plaka'] = plaka;
    data['uuid'] = uuid;
    data['sehiradi'] = sehiradi;
    return data;
  }
}
