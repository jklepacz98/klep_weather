import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class City {
  City({
    required this.id,
    required this.name,
  });

  int id;
  String name;

}
