import 'package:flutter/material.dart';
import '../../data/repositories/waypoint_repository.dart';
import '../theme/lcars_theme.dart';
import 'dossier_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final waypoints = WaypointRepository.getAllWaypoints();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("MISSION CARTOGRAPHY", style: TextStyle(fontSize: 11, color: LcarsTheme.cyanSecondary, letterSpacing: 1.5)),
            Text("Expedition Waypoint HUD", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: waypoints.length,
        itemBuilder: (context, index) {
          final wp = waypoints[index];
          return Card(
            color: LcarsTheme.surfaceDark,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: LcarsTheme.borderGlass),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                backgroundColor: LcarsTheme.surfaceVariant,
                child: Text("${index + 1}", style: const TextStyle(color: LcarsTheme.amberGlow, fontWeight: FontWeight.bold)),
              ),
              title: Text(wp.name, style: const TextStyle(color: LcarsTheme.textPrimary, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text("📍 ${wp.lat.toStringAsFixed(4)}, ${wp.lng.toStringAsFixed(4)} | ${wp.elevationFeet.toInt()} ft", style: const TextStyle(color: LcarsTheme.textSecondary, fontSize: 12)),
                  const SizedBox(height: 2),
                  Text("☀️ Target: ${wp.targetLightPhase}", style: const TextStyle(color: LcarsTheme.cyanSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
              trailing: const Icon(Icons.chevron_right, color: LcarsTheme.amberPrimary),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DossierScreen(waypoint: wp)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
