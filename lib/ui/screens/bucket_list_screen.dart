import 'package:flutter/material.dart';
import '../../data/repositories/waypoint_repository.dart';
import '../../data/models/waypoint.dart';
import '../theme/lcars_theme.dart';

class BucketListScreen extends StatefulWidget {
  const BucketListScreen({super.key});

  @override
  State<BucketListScreen> createState() => _BucketListScreenState();
}

class _BucketListScreenState extends State<BucketListScreen> {
  late List<Waypoint> waypoints;

  @override
  void initState() {
    super.initState();
    waypoints = WaypointRepository.getAllWaypoints();
  }

  @override
  Widget build(BuildContext context) {
    final visitedCount = waypoints.where((w) => w.isVisited).length;
    final progress = waypoints.isEmpty ? 0.0 : visitedCount / waypoints.length;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("MISSION LOG", style: TextStyle(fontSize: 11, color: LcarsTheme.cyanSecondary, letterSpacing: 1.5)),
            Text("Expedition Bucket List", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              border: Border.all(color: LcarsTheme.amberPrimary.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("COMPLETION STATUS", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                    Text("$visitedCount / ${waypoints.length} EXPLORED", style: const TextStyle(color: LcarsTheme.amberGlow, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: LcarsTheme.surfaceVariant,
                  valueColor: const AlwaysStoppedAnimation(LcarsTheme.amberPrimary),
                  minHeight: 8,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: waypoints.length,
              itemBuilder: (context, index) {
                final wp = waypoints[index];
                return Card(
                  color: LcarsTheme.surfaceDark,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: CheckboxListTile(
                    activeColor: LcarsTheme.greenSuccess,
                    checkColor: Colors.black,
                    title: Text(wp.name, style: TextStyle(
                      color: wp.isVisited ? LcarsTheme.textSecondary : LcarsTheme.textPrimary,
                      decoration: wp.isVisited ? TextDecoration.lineThrough : null,
                      fontWeight: FontWeight.w600,
                    )),
                    subtitle: Text("${wp.state} • ${wp.targetLightPhase}", style: const TextStyle(color: LcarsTheme.cyanSecondary, fontSize: 12)),
                    value: wp.isVisited,
                    onChanged: (val) {
                      setState(() {
                        waypoints[index] = wp.copyWith(isVisited: val ?? false);
                      });
                    },
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
