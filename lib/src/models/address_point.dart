import 'package:flutter_polyline_points/src/models/address_point_mixin.dart';

class AddressPoint with AddressPointMixin {
  const AddressPoint({
    required this.latitude,
    required this.longitude,
  });

  factory AddressPoint.fromJson(Map<String, dynamic> json) => AddressPoint(
        latitude: json['lat']?.toDouble(),
        longitude: json['lng']?.toDouble(),
      );

  @override
  final double latitude;
  @override
  final double longitude;

  AddressPoint copyWith({
    double? lat,
    double? lng,
  }) =>
      AddressPoint(
        latitude: lat ?? latitude,
        longitude: lng ?? longitude,
      );

  Map<String, dynamic> toJson() => {
        'lat': latitude,
        'lng': longitude,
      };
}
