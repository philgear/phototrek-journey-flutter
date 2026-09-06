import 'package:flutter/material.dart';
import '../../domain/solar/sun_calc_engine.dart';
import '../../data/models/sun_position.dart';
import '../theme/lcars_theme.dart';

class SolarArScreen extends StatefulWidget {
  const SolarArScreen({super.key});

  @override
  State<SolarArScreen> createState() => _SolarArScreenState();
}

class _SolarArScreenState extends State<SolarArScreen> {
  late SunPosition sun;

  @override
  void initState() {
    super.initState();
    _recalculate();
  }

  void _recalculate() {
    // Portland default coordinates
    sun = SunCalcEngine.calculatePosition(DateTime.now(), 45.5152, -122.6784);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("OPTICAL TELEMETRY", style: TextStyle(fontSize: 11, color: LcarsTheme.cyanSecondary, letterSpacing: 1.5)),
            Text("Solar Azimuth Compass HUD", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: LcarsTheme.surfaceDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: LcarsTheme.amberPrimary.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("AZIMUTH", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                      Text("${sun.azimuthDegrees.toStringAsFixed(1)}°", style: const TextStyle(color: LcarsTheme.amberGlow, fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("ELEVATION", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                      Text("${sun.elevationDegrees.toStringAsFixed(1)}°", style: const TextStyle(color: LcarsTheme.cyanSecondary, fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("LIGHT PHASE", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                      Text(sun.phase, style: const TextStyle(color: LcarsTheme.greenSuccess, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LcarsTheme.surfaceDark,
                    border: Border.all(color: LcarsTheme.cyanSecondary.withValues(alpha: 0.5), width: 3),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text("N", style: TextStyle(color: LcarsTheme.amberPrimary, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                      Transform.rotate(
                        angle: (sun.azimuthDegrees) * (3.14159 / 180.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Icon(Icons.wb_sunny, color: LcarsTheme.amberGlow, size: 36),
                            Container(width: 2, height: 80, color: LcarsTheme.amberGlow),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
