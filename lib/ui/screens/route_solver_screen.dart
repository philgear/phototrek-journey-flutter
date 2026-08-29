import 'package:flutter/material.dart';
import '../../data/repositories/waypoint_repository.dart';
import '../../domain/vrp/vrp_optimizer.dart';
import '../theme/lcars_theme.dart';

class RouteSolverScreen extends StatefulWidget {
  const RouteSolverScreen({super.key});

  @override
  State<RouteSolverScreen> createState() => _RouteSolverScreenState();
}

class _RouteSolverScreenState extends State<RouteSolverScreen> {
  late RouteResult result;

  @override
  void initState() {
    super.initState();
    final waypoints = WaypointRepository.getAllWaypoints();
    result = VrpOptimizer.solveTsp(waypoints);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("AI ROUTING SOLVER", style: TextStyle(fontSize: 11, color: LcarsTheme.cyanSecondary, letterSpacing: 1.5)),
            Text("Expedition VRP Itinerary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: LcarsTheme.surfaceDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: LcarsTheme.cyanSecondary.withOpacity(0.4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text("TOTAL DISTANCE", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                    Text("${result.totalDistanceMiles.toStringAsFixed(1)} mi", style: const TextStyle(color: LcarsTheme.amberGlow, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text("DRIVING DURATION", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                    Text("${result.estimatedDrivingHours.toStringAsFixed(1)} hrs", style: const TextStyle(color: LcarsTheme.cyanSecondary, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text("WAYPOINTS", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                    Text("${result.orderedWaypoints.length}", style: const TextStyle(color: LcarsTheme.greenSuccess, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: result.orderedWaypoints.length,
              itemBuilder: (context, index) {
                final wp = result.orderedWaypoints[index];
                return Card(
                  color: LcarsTheme.surfaceDark,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: LcarsTheme.borderGlass),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: LcarsTheme.surfaceVariant,
                      child: Text("S${index + 1}", style: const TextStyle(color: LcarsTheme.amberGlow, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    title: Text(wp.name, style: const TextStyle(color: LcarsTheme.textPrimary, fontWeight: FontWeight.bold)),
                    subtitle: Text("⏰ Ideal: ${(wp.idealTimeMin ~/ 60).toString().padLeft(2, '0')}:${(wp.idealTimeMin % 60).toString().padLeft(2, '0')} • ${wp.serviceDurationMinutes}m shoot", style: const TextStyle(color: LcarsTheme.cyanSecondary, fontSize: 12)),
                    trailing: const Icon(Icons.check_circle_outline, color: LcarsTheme.greenSuccess),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
