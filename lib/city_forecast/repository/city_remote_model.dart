import 'package:json_annotation/json_annotation.dart';

part 'city_remote_model.g.dart';

@JsonSerializable()
class CityRemoteModel {
  CityRemoteModel({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory CityRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$CityRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityRemoteModelToJson(this);
}
