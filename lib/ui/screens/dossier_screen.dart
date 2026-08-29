import 'package:flutter/material.dart';
import '../../data/models/waypoint.dart';
import '../theme/lcars_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DossierScreen extends StatelessWidget {
  final Waypoint waypoint;

  const DossierScreen({super.key, required this.waypoint});

  Future<void> _launchMapsNavigation() async {
    final uri = Uri.parse("https://www.google.com/maps/dir/?api=1&destination=${waypoint.lat},${waypoint.lng}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(waypoint.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: LcarsTheme.surfaceDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: LcarsTheme.borderGlass),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("LOCATION DOSSIER", style: const TextStyle(color: LcarsTheme.cyanSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(waypoint.name, style: const TextStyle(color: LcarsTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                Text("${waypoint.state} • ${waypoint.elevationFeet.toInt()} ft elevation", style: const TextStyle(color: LcarsTheme.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: LcarsTheme.surfaceDark,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("📷 OPTICAL & COMPOSITION TIP", style: TextStyle(color: LcarsTheme.amberGlow, fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(waypoint.compositionTip, style: const TextStyle(color: LcarsTheme.textPrimary)),
                  const SizedBox(height: 12),
                  const Text("🔭 RECOMMENDED OPTICS", style: TextStyle(color: LcarsTheme.cyanSecondary, fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(waypoint.recommendedFocalLength, style: const TextStyle(color: LcarsTheme.textPrimary)),
                  const SizedBox(height: 12),
                  const Text("🌋 GEOLOGICAL FORMATION", style: TextStyle(color: LcarsTheme.greenSuccess, fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(waypoint.geologicalNote, style: const TextStyle(color: LcarsTheme.textPrimary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: LcarsTheme.amberPrimary,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.navigation),
            label: const Text("Launch Navigation (Apple / Google Maps)", style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: _launchMapsNavigation,
          ),
        ],
      ),
    );
  }
}
