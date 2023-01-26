import 'package:json_annotation/json_annotation.dart';

part 'coord_remote_model.g.dart';

@JsonSerializable()
class CoordRemoteModel {
  CoordRemoteModel({
    required this.lon,
    required this.lat,
  });

  double lon;
  double lat;

  factory CoordRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$CoordRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordRemoteModelToJson(this);
}
