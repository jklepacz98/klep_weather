import 'package:json_annotation/json_annotation.dart';

part 'main_info_remote_model.g.dart';

@JsonSerializable()
class MainInfoRemoteModel {
  MainInfoRemoteModel({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  double temp;
  @JsonKey(name: 'feels_like')
  double feelsLike;
  @JsonKey(name: 'temp_min')
  double tempMin;
  @JsonKey(name: 'temp_max')
  double tempMax;
  int pressure;
  int humidity;

  factory MainInfoRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$MainInfoRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainInfoRemoteModelToJson(this);
}
