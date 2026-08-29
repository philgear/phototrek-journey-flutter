import 'vrp_optimizer.dart';
import '../../data/models/school_trip_plan.dart';

class ScheduleStop {
  final SchoolFieldTripWaypoint waypoint;
  final int arrivalTimeMin;
  final int departureTimeMin;
  final bool isInTimeWindow;

  const ScheduleStop({
    required this.waypoint,
    required this.arrivalTimeMin,
    required this.departureTimeMin,
    required this.isInTimeWindow,
  });
}

class TripScheduleResult {
  final double totalDistanceMiles;
  final double totalDurationHours;
  final int estimatedReturnTimeMinutes;
  final bool isBeforeDismissalBell;
  final int marginMinutesBeforeBell;
  final SchoolBusBudget budget;
  final List<ScheduleStop> itinerary;

  const TripScheduleResult({
    required this.totalDistanceMiles,
    required this.totalDurationHours,
    required this.estimatedReturnTimeMinutes,
    required this.isBeforeDismissalBell,
    required this.marginMinutesBeforeBell,
    required this.budget,
    required this.itinerary,
  });
}

class SchoolBusVrpOptimizer {
  static TripScheduleResult planFieldTrip({
    required double schoolLat,
    required double schoolLng,
    required String schoolName,
    required List<SchoolFieldTripWaypoint> stops,
    int studentCount = 28,
    int departureMin = 510, // 08:30 AM
    int dismissalDeadlineMin = 900, // 03:00 PM
    double citizenScienceOffset = 0.0,
  }) {
    var currentClock = departureMin;
    var totalDist = 0.0;
    var prevLat = schoolLat;
    var prevLng = schoolLng;
    final schedule = <ScheduleStop>[];

    for (final stop in stops) {
      final dist = VrpOptimizer.calculateHaversineDistanceMiles(prevLat, prevLng, stop.lat, stop.lng);
      final transitMins = ((dist / 40.0) * 60).toInt() + 10; // 10 min bus loading buffer

      final arrival = currentClock + transitMins;
      final departure = arrival + 60; // 1 hr at site
      final inWindow = arrival >= (stop.bookedTimeWindowStartMin - 15) && arrival <= stop.bookedTimeWindowEndMin;

      schedule.add(ScheduleStop(
        waypoint: stop,
        arrivalTimeMin: arrival,
        departureTimeMin: departure,
        isInTimeWindow: inWindow,
      ));

      totalDist += dist;
      currentClock = departure;
      prevLat = stop.lat;
      prevLng = stop.lng;
    }

    final returnDist = VrpOptimizer.calculateHaversineDistanceMiles(prevLat, prevLng, schoolLat, schoolLng);
    final returnTransitMins = ((returnDist / 40.0) * 60).toInt() + 10;
    final finalReturnTime = currentClock + returnTransitMins;
    totalDist += returnDist;

    final totalHours = (finalReturnTime - departureMin) / 60.0;
    final margin = dismissalDeadlineMin - finalReturnTime;

    final budget = SchoolBusBudget(
      totalMiles: totalDist,
      totalHours: totalHours,
      studentCount: studentCount,
      citizenScienceFundingOffset: citizenScienceOffset,
    );

    return TripScheduleResult(
      totalDistanceMiles: totalDist,
      totalDurationHours: totalHours,
      estimatedReturnTimeMinutes: finalReturnTime,
      isBeforeDismissalBell: margin >= 0,
      marginMinutesBeforeBell: margin,
      budget: budget,
      itinerary: schedule,
    );
  }

  static String formatMinutesToClock(int minutesFromMidnight) {
    final hr = minutesFromMidnight ~/ 60;
    final min = minutesFromMidnight % 60;
    final period = hr >= 12 ? "PM" : "AM";
    final displayHr = hr > 12 ? hr - 12 : (hr == 0 ? 12 : hr);
    return "${displayHr.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')} $period";
  }
}
