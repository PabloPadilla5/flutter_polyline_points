import 'package:flutter_polyline_points/src/models/address_point.dart';

import 'package:flutter_polyline_points/src/models/direction_overview_polyline.dart';
import 'package:flutter_polyline_points/src/models/direction_route_bounds.dart';
import 'package:flutter_polyline_points/src/models/direction_route_leg.dart';

class DirectionRoute {
  const DirectionRoute({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
    required this.summary,
    required this.warnings,
    required this.waypointOrder,
  });

  factory DirectionRoute.fromJson(Map<String, dynamic> json) => DirectionRoute(
        bounds: DirectionRouteBounds.fromJson(json['bounds']),
        copyrights: json['copyrights'],
        legs: List<DirectionRouteLeg>.from(
            json['legs'].map((x) => DirectionRouteLeg.fromJson(x))),
        overviewPolyline:
            DirectionOverviewPolyline.fromJson(json['overview_polyline']),
        summary: json['summary'],
        warnings: List<dynamic>.from(json['warnings'].map((x) => x)),
        waypointOrder: List<dynamic>.from(json['waypoint_order'].map((x) => x)),
      );

  final DirectionRouteBounds bounds;
  final String copyrights;
  final List<DirectionRouteLeg> legs;
  final DirectionOverviewPolyline overviewPolyline;
  final String summary;
  final List<dynamic> warnings;
  final List<dynamic> waypointOrder;

  List<AddressPoint> get polyline =>
      decodeEncodedPolyline(overviewPolyline.points);

  DirectionRouteLeg get shortestLeg => (legs
        ..sort((l1, l2) => l1.distanceInMeters.compareTo(l2.distanceInMeters)))
      .first;

  DirectionRoute copyWith({
    DirectionRouteBounds? bounds,
    String? copyrights,
    List<DirectionRouteLeg>? legs,
    DirectionOverviewPolyline? overviewPolyline,
    String? summary,
    List<dynamic>? warnings,
    List<dynamic>? waypointOrder,
  }) =>
      DirectionRoute(
        bounds: bounds ?? this.bounds,
        copyrights: copyrights ?? this.copyrights,
        legs: legs ?? this.legs,
        overviewPolyline: overviewPolyline ?? this.overviewPolyline,
        summary: summary ?? this.summary,
        warnings: warnings ?? this.warnings,
        waypointOrder: waypointOrder ?? this.waypointOrder,
      );

  Map<String, dynamic> toJson() => {
        'bounds': bounds.toJson(),
        'copyrights': copyrights,
        'legs': List<dynamic>.from(legs.map((x) => x.toJson())),
        'overview_polyline': overviewPolyline.toJson(),
        'summary': summary,
        'warnings': List<dynamic>.from(warnings.map((x) => x)),
        'waypoint_order': List<dynamic>.from(waypointOrder.map((x) => x)),
      };

  ///decode the google encoded string using Encoded Polyline Algorithm Format
  /// for more info about the algorithm check https://developers.google.com/maps/documentation/utilities/polylinealgorithm
  ///
  ///return [List]
  List<AddressPoint> decodeEncodedPolyline(String encoded) {
    List<AddressPoint> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      AddressPoint p = AddressPoint(
          latitude: (lat / 1E5).toDouble(), longitude: (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }
}
