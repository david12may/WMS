// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.id,
    required this.apiKey,
    required this.correo,
  });

  int id;
  String apiKey;
  String correo;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["id"],
        apiKey: json["api_key"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "api_key": apiKey,
        "correo": correo,
      };
}
