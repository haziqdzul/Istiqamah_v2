// To parse this JSON data, do
//
//     final states = statesFromMap(jsonString);

import 'dart:convert';

StatesModel statesFromMap(String str) => StatesModel.fromMap(json.decode(str));

String statesToMap(StatesModel data) => json.encode(data.toMap());

class StatesModel {
  StatesModel({
    required this.state,
  });

  List<StateModel> state;

  factory StatesModel.fromMap(Map<String, dynamic> json) => StatesModel(
        state: List<StateModel>.from(
            json["state"].map((x) => StateModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "state": List<dynamic>.from(state.map((x) => x.toMap())),
      };
}

class StateModel {
  StateModel({
    required this.name,
    required this.city,
  });

  String name;
  List<CityModel> city;

  factory StateModel.fromMap(Map<String, dynamic> json) => StateModel(
        name: json["name"],
        city: List<CityModel>.from(json["city"].map((x) => CityModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "city": List<dynamic>.from(city.map((x) => x.toMap())),
      };
}

class CityModel {
  CityModel({
    required this.name,
    required this.postcode,
  });

  String name;
  List<String> postcode;

  factory CityModel.fromMap(Map<String, dynamic> json) => CityModel(
        name: json["name"],
        postcode: List<String>.from(json["postcode"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "postcode": List<dynamic>.from(postcode.map((x) => x)),
      };
}
