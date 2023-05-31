library flutter_polyline_points;

import 'package:flutter_polyline_points/src/models/direction_route.dart';
import 'package:flutter_polyline_points/src/utils/polyline_waypoint.dart';
import 'package:flutter_polyline_points/src/utils/request_enums.dart';
import 'src/PointLatLng.dart';
import 'src/network_util.dart';

export 'src/utils/request_enums.dart';
export 'src/utils/polyline_waypoint.dart';
export 'src/network_util.dart';
export 'src/PointLatLng.dart';
export 'src/utils/polyline_result.dart';
export 'src/models/direction_route.dart';

class PolylinePoints {
  NetworkUtil util = NetworkUtil();

  /// Get the list of coordinates between two geographical positions
  /// which can be used to draw polyline between this two positions
  ///
  Future<DirectionRoute> getRouteBetweenCoordinates(
      String googleApiKey, PointLatLng origin, PointLatLng destination,
      {TravelMode travelMode = TravelMode.driving,
      List<PolylineWayPoint> wayPoints = const [],
      bool avoidHighways = false,
      bool avoidTolls = false,
      bool avoidFerries = true,
      bool optimizeWaypoints = false}) async {
    return await util.getRouteBetweenCoordinates(
        googleApiKey,
        origin,
        destination,
        travelMode,
        wayPoints,
        avoidHighways,
        avoidTolls,
        avoidFerries,
        optimizeWaypoints);
  }
}
