import 'package:json_annotation/json_annotation.dart';

part 'wind_remote_model.g.dart';

@JsonSerializable()
class WindRemoteModel {
  WindRemoteModel({required this.speed, required this.deg});

  int deg;
  double speed;

  factory WindRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$WindRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindRemoteModelToJson(this);
}
