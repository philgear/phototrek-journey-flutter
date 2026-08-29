import 'dart:math' as math;
import '../../data/models/waypoint.dart';

class RouteResult {
  final List<Waypoint> orderedWaypoints;
  final double totalDistanceMiles;
  final double estimatedDrivingHours;
  final int totalExpeditionMinutes;

  const RouteResult({
    required this.orderedWaypoints,
    required this.totalDistanceMiles,
    required this.estimatedDrivingHours,
    required this.totalExpeditionMinutes,
  });
}

class VrpOptimizer {
  static const double earthRadiusMiles = 3958.8;

  static double calculateHaversineDistanceMiles(double lat1, double lon1, double lat2, double lon2) {
    final double dLat = (lat2 - lat1) * (math.pi / 180.0);
    final double dLon = (lon2 - lon1) * (math.pi / 180.0);
    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1 * (math.pi / 180.0)) * math.cos(lat2 * (math.pi / 180.0)) *
        math.sin(dLon / 2) * math.sin(dLon / 2);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusMiles * c;
  }

  static RouteResult solveTsp(List<Waypoint> waypoints, {double avgSpeedMph = 45.0}) {
    if (waypoints.isEmpty) {
      return const RouteResult(
        orderedWaypoints: [],
        totalDistanceMiles: 0,
        estimatedDrivingHours: 0,
        totalExpeditionMinutes: 0,
      );
    }

    final unvisited = List<Waypoint>.from(waypoints);
    final route = <Waypoint>[unvisited.removeAt(0)];

    while (unvisited.isNotEmpty) {
      final current = route.last;
      var bestIdx = 0;
      var bestDist = double.infinity;

      for (var i = 0; i < unvisited.length; i++) {
        final dist = calculateHaversineDistanceMiles(
          current.lat, current.lng, unvisited[i].lat, unvisited[i].lng,
        );
        if (dist < bestDist) {
          bestDist = dist;
          bestIdx = i;
        }
      }
      route.add(unvisited.removeAt(bestIdx));
    }

    // 2-Opt Optimization Pass
    var improved = true;
    while (improved) {
      improved = false;
      for (var i = 1; i < route.length - 1; i++) {
        for (var k = i + 1; k < route.length; k++) {
          final d1 = calculateHaversineDistanceMiles(route[i - 1].lat, route[i - 1].lng, route[i].lat, route[i].lng) +
              calculateHaversineDistanceMiles(route[k].lat, route[k].lng, route[(k + 1) % route.length].lat, route[(k + 1) % route.length].lng);
          final d2 = calculateHaversineDistanceMiles(route[i - 1].lat, route[i - 1].lng, route[k].lat, route[k].lng) +
              calculateHaversineDistanceMiles(route[i].lat, route[i].lng, route[(k + 1) % route.length].lat, route[(k + 1) % route.length].lng);
          if (d2 < d1) {
            final sub = route.sublist(i, k + 1).reversed.toList();
            route.replaceRange(i, k + 1, sub);
            improved = true;
          }
        }
      }
    }

    var totalDist = 0.0;
    var totalServiceMins = 0;
    for (var i = 0; i < route.length - 1; i++) {
      totalDist += calculateHaversineDistanceMiles(route[i].lat, route[i].lng, route[i + 1].lat, route[i + 1].lng);
      totalServiceMins += route[i].serviceDurationMinutes;
    }
    totalServiceMins += route.last.serviceDurationMinutes;

    final drivingHours = totalDist / avgSpeedMph;
    final totalMins = (drivingHours * 60).toInt() + totalServiceMins;

    return RouteResult(
      orderedWaypoints: route,
      totalDistanceMiles: totalDist,
      estimatedDrivingHours: drivingHours,
      totalExpeditionMinutes: totalMins,
    );
  }
}
