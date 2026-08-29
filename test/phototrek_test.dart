import 'package:flutter_test/flutter_test.dart';
import 'package:phototrek_flutter/domain/solar/sun_calc_engine.dart';
import 'package:phototrek_flutter/domain/vrp/vrp_optimizer.dart';
import 'package:phototrek_flutter/domain/vrp/school_bus_vrp_optimizer.dart';
import 'package:phototrek_flutter/data/repositories/waypoint_repository.dart';

void main() {
  group('SunCalcEngine Astronomical Tests', () {
    test('Calculates solar azimuth and elevation for summer solstice', () {
      final date = DateTime(2026, 6, 21, 12, 0);
      final sun = SunCalcEngine.calculatePosition(date, 45.5152, -122.6784);
      expect(sun.elevationDegrees, greaterThan(60.0));
      expect(sun.phase, equals("Daylight"));
    });
  });

  group('VRP Optimizer TSP Tests', () {
    test('Calculates non-zero optimal distance across waypoints', () {
      final waypoints = WaypointRepository.getAllWaypoints();
      final result = VrpOptimizer.solveTsp(waypoints);
      expect(result.orderedWaypoints.length, equals(waypoints.length));
      expect(result.totalDistanceMiles, greaterThan(100.0));
      expect(result.estimatedDrivingHours, greaterThan(2.0));
    });
  });

  group('School Bus VRP & Micro-Grant Tests', () {
    test('Calculates on-time dismissal margin and citizen science grant reduction', () {
      final trip = SchoolBusVrpOptimizer.planFieldTrip(
        schoolLat: 45.5152,
        schoolLng: -122.6784,
        schoolName: "Lincoln High School",
        stops: [],
        citizenScienceOffset: 50.0,
      );
      expect(trip.isBeforeDismissalBell, isTrue);
      expect(trip.budget.citizenScienceFundingOffset, equals(50.0));
    });
  });
}
