class WarningModel {
  int? id;
  int? typeId;
  String? description;
  int? userId;
  String? createdAt;
  String? title;
  String? iconUrl;
  String? sehiradi;

  WarningModel(
      {this.id,
      this.typeId,
      this.description,
      this.userId,
      this.createdAt,
      this.title,
      this.iconUrl,
      this.sehiradi});

  WarningModel.fromJson(Map<String, dynamic> json) {
    id = json[id];
    typeId = json[typeId];
    description = json['description'];
    userId = json[userId];
    createdAt = json['createdAt'];
    title = json['title'];
    iconUrl = json['iconUrl'];
    sehiradi = json['sehiradi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['typeId'] = typeId;
    data['description'] = description;
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['iconUrl'] = iconUrl;
    data['sehiradi'] = sehiradi;
    return data;
  }
}
