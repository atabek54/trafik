class Cities {
  int? id;
  String? sehiradi;

  Cities({this.id, this.sehiradi});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json[id];
    sehiradi = json['sehiradi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sehiradi'] = sehiradi;
    return data;
  }
}
