import 'package:json_annotation/json_annotation.dart';

part 'clouds_remote_model.g.dart';

@JsonSerializable()
class CloudsRemoteModel {
  CloudsRemoteModel({required this.all});

  int all;

  factory CloudsRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$CloudsRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsRemoteModelToJson(this);
}
