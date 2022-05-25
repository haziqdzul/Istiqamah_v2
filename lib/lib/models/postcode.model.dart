import 'dart:convert';

List<PostCodeModel> welcomeFromMap(String str) => List<PostCodeModel>.from(
    json.decode(str).map((x) => PostCodeModel.fromMap(x)));

String welcomeToMap(List<PostCodeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PostCodeModel {
  PostCodeModel({
    required this.stateId,
    required this.code,
  });

  int stateId;
  String code;

  factory PostCodeModel.fromMap(Map<String, dynamic> json) => PostCodeModel(
        stateId: json["state_id"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "state_id": stateId,
        "code": code,
      };
}
