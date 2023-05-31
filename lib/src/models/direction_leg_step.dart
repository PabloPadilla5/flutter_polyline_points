import 'package:flutter_polyline_points/src/models/route_distance.dart';
import 'package:flutter_polyline_points/src/models/route_duration.dart';

import 'package:flutter_polyline_points/src/models/address_point.dart';
import 'package:flutter_polyline_points/src/models/direction_overview_polyline.dart';

class DirectionLegStep {
  const DirectionLegStep({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.htmlInstructions,
    required this.polyline,
    required this.startLocation,
    required this.travelMode,
    this.maneuver,
  });

  factory DirectionLegStep.fromJson(Map<String, dynamic> json) =>
      DirectionLegStep(
        distance: RouteDistance.fromJson(json['distance']),
        duration: RouteDuration.fromJson(json['duration']),
        endLocation: AddressPoint.fromJson(json['end_location']),
        htmlInstructions: json['html_instructions'],
        polyline: DirectionOverviewPolyline.fromJson(json['polyline']),
        startLocation: AddressPoint.fromJson(json['start_location']),
        travelMode: json['travel_mode'],
        maneuver: json['maneuver'],
      );

  final RouteDistance distance;
  final RouteDuration duration;
  final AddressPoint endLocation;
  final String htmlInstructions;
  final String? maneuver;
  final DirectionOverviewPolyline polyline;
  final AddressPoint startLocation;
  final String travelMode;

  DirectionLegStep copyWith({
    RouteDistance? distance,
    RouteDuration? duration,
    AddressPoint? endLocation,
    String? htmlInstructions,
    DirectionOverviewPolyline? polyline,
    AddressPoint? startLocation,
    String? travelMode,
    String? maneuver,
  }) =>
      DirectionLegStep(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        endLocation: endLocation ?? this.endLocation,
        htmlInstructions: htmlInstructions ?? this.htmlInstructions,
        polyline: polyline ?? this.polyline,
        startLocation: startLocation ?? this.startLocation,
        travelMode: travelMode ?? this.travelMode,
        maneuver: maneuver ?? this.maneuver,
      );

  Map<String, dynamic> toJson() => {
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'end_location': endLocation.toJson(),
        'html_instructions': htmlInstructions,
        'polyline': polyline.toJson(),
        'start_location': startLocation.toJson(),
        'travel_mode': travelMode,
        'maneuver': maneuver,
      };
}
