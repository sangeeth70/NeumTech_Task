// To parse this JSON data, do
//
//     final userdata = userdataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Userdata userdataFromJson(String str) => Userdata.fromJson(json.decode(str));

String userdataToJson(Userdata data) => json.encode(data.toJson());

class Userdata {
  Userdata({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  final List<Datum> data;
  final int total;
  final int page;
  final int limit;

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "page": page,
    "limit": limit,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  final String id;
  final Title title;
  final String firstName;
  final String lastName;
  final String picture;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: titleValues.map[json["title"]]!,
    firstName: json["firstName"],
    lastName: json["lastName"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": titleValues.reverse[title],
    "firstName": firstName,
    "lastName": lastName,
    "picture": picture,
  };
}

enum Title { MS, MISS, MR, MRS }

final titleValues = EnumValues({
  "miss": Title.MISS,
  "mr": Title.MR,
  "mrs": Title.MRS,
  "ms": Title.MS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
