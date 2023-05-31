import 'package:flutter_polyline_points/src/models/address_point.dart';

class DirectionRouteBounds {
  const DirectionRouteBounds({
    required this.northeast,
    required this.southwest,
  });

  factory DirectionRouteBounds.fromJson(Map<String, dynamic> json) =>
      DirectionRouteBounds(
        northeast: AddressPoint.fromJson(json["northeast"]),
        southwest: AddressPoint.fromJson(json["southwest"]),
      );

  final AddressPoint northeast;
  final AddressPoint southwest;

  DirectionRouteBounds copyWith({
    AddressPoint? northeast,
    AddressPoint? southwest,
  }) {
    return DirectionRouteBounds(
      northeast: northeast ?? this.northeast,
      southwest: southwest ?? this.southwest,
    );
  }

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}
