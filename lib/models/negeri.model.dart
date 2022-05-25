// To parse this JSON data, do
//
//     final kelantan = kelantanFromMap(jsonString);

import 'dart:convert';

Negeri negeriFromMap(String str) => Negeri.fromJson(json.decode(str));

String negeriToMap(Negeri data) => json.encode(data.toMap());

class Negeri {
  Negeri({
    required this.city,
  });

  List<Bandar> city;

  factory Negeri.fromJson(Map<String, dynamic> json) => Negeri(
        city: List<Bandar>.from(json["city"].map((x) => Bandar.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "city": List<dynamic>.from(city.map((x) => x.toMap())),
      };
}

class Bandar {
  Bandar({
    required this.id,
    required this.name,
    required this.stateId,
  });

  int id;
  String name;
  int stateId;

  factory Bandar.fromJson(Map<String, dynamic> json) => Bandar(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "state_id": stateId,
      };
}
