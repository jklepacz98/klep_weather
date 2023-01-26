import 'package:json_annotation/json_annotation.dart';

part 'sys_remote_model.g.dart';

@JsonSerializable()
class SysRemoteModel {
  SysRemoteModel({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  factory SysRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$SysRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$SysRemoteModelToJson(this);
}
