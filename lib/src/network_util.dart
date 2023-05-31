import 'dart:convert';
import 'dart:developer';

import 'package:flutter_polyline_points/src/models/address_point.dart';
import 'package:flutter_polyline_points/src/models/direction_route.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_polyline_points/src/utils/polyline_waypoint.dart';
import 'package:flutter_polyline_points/src/utils/request_enums.dart';

class NetworkUtil {
  static const String statusOk = 'ok';

  ///Get the encoded string from google directions api
  ///
  Future<DirectionRoute> getRouteBetweenCoordinates(
      String googleApiKey,
      AddressPoint origin,
      AddressPoint destination,
      TravelMode travelMode,
      List<PolylineWayPoint> wayPoints,
      bool avoidHighways,
      bool avoidTolls,
      bool avoidFerries,
      bool optimizeWaypoints) async {
    String mode = travelMode.toString().replaceAll('TravelMode.', '');
    var params = {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'mode': mode,
      'key': googleApiKey
    };
    // Build the "avoid" parameter which should be formatted the following way:
    // avoid=tolls|highways|ferries
    // See more: https://developers.google.com/maps/documentation/directions/get-directions#avoid
    String avoid = '${avoidTolls ? 'tolls|' : ''}'
        '${avoidHighways ? 'highways|' : ''}${avoidFerries ? 'ferries|' : ''}';
    if (avoid.isNotEmpty) {
      // Remove the last character of the generated String which should be "|"
      avoid = avoid.substring(0, avoid.length - 1);
      params['avoid'] = avoid;
    }

    if (wayPoints.isNotEmpty) {
      List<String> wayPointsArray = [];
      wayPoints.forEach((point) => wayPointsArray.add(point.location));
      String wayPointsString = wayPointsArray.join('|');
      if (optimizeWaypoints) {
        wayPointsString = 'optimize:true|$wayPointsString';
      }
      params.addAll({'waypoints': wayPointsString});
    }
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/directions/json', params);

    log('Google Maps URL: ${uri.toString()}');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      if (parsedJson['status']?.toLowerCase() == statusOk &&
          parsedJson['routes'] != null &&
          parsedJson['routes'].isNotEmpty) {
        final routes = List<DirectionRoute>.from(
            parsedJson['routes'].map((x) => DirectionRoute.fromJson(x)));
        return routes.first;
      } else {
        return Future.error(parsedJson['error_message']);
      }
    }
    return Future.error('Unknown error');
  }
}
