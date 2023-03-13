import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/geocoding/model/location_model.dart';

part 'geocoding_model.g.dart';

@JsonSerializable()
class GeocodingModel {
  GeocodingModel({required this.locationModelList});

  List<LocationModel> locationModelList;

  factory GeocodingModel.fromJson(Map<String, dynamic> json) =>
      _$GeocodingModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodingModelToJson(this);
}
