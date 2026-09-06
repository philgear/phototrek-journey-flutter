import 'package:flutter/material.dart';
import '../../data/models/school_trip_plan.dart';
import '../../domain/vrp/school_bus_vrp_optimizer.dart';
import '../theme/lcars_theme.dart';

class SchoolTripScreen extends StatefulWidget {
  const SchoolTripScreen({super.key});

  @override
  State<SchoolTripScreen> createState() => _SchoolTripScreenState();
}

class _SchoolTripScreenState extends State<SchoolTripScreen> {
  var headcount = const AnonymousHeadcount(expectedCount: 28, boardedCount: 28);
  var citizenSciCount = 64;

  final sampleStops = [
    const SchoolFieldTripWaypoint(
      id: "omsi-science",
      name: "OMSI Science & Planetarium Dome",
      lat: 45.5085,
      lng: -122.6658,
      bookedTimeWindowStartMin: 570,
      bookedTimeWindowEndMin: 675,
      parkingBusZoneInfo: "Bus Bay 3 (South Lot, Free Bus Pass)",
      teachableMoment: TeachableMoment(
        topic: "Optics & Planetary Astronomy",
        subjectArea: "Physics / Space STEM",
        intercomDiscussionPrompt: "Notice how submarine periscopes use internal reflection prisms—just like optical camera zoom lenses!",
      ),
    ),
    const SchoolFieldTripWaypoint(
      id: "bonneville-dam",
      name: "Bonneville Dam & Sturgeon Center",
      lat: 45.6443,
      lng: -121.9442,
      bookedTimeWindowStartMin: 720,
      bookedTimeWindowEndMin: 810,
      parkingBusZoneInfo: "Commercial Bus Loop at Visitor Center",
      teachableMoment: TeachableMoment(
        topic: "Hydroelectric Energy & River Ecology",
        subjectArea: "Earth Science",
        intercomDiscussionPrompt: "Bonneville Dam generates 1.2 gigawatts of clean hydroelectric energy—powering over 900,000 homes!",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final earnedGrantOffset = citizenSciCount * 0.50;
    final tripPlan = SchoolBusVrpOptimizer.planFieldTrip(
      schoolLat: 45.5152,
      schoolLng: -122.6784,
      schoolName: "Lincoln High School",
      stops: sampleStops,
      studentCount: 28,
      citizenScienceOffset: earnedGrantOffset,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("COPPA-SAFE EDUCATOR & BUS DISPATCH", style: TextStyle(fontSize: 11, color: LcarsTheme.cyanSecondary, letterSpacing: 1.5)),
            Text("Teachable Field Trip Planner", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Anonymous Headcount HUD (0 PII)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: LcarsTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: headcount.isAllAccountedFor ? LcarsTheme.greenSuccess.withValues(alpha: 0.5) : LcarsTheme.amberPrimary,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("ANONYMOUS PASSENGER TALLY", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(
                      headcount.isAllAccountedFor ? "ALL ${headcount.boardedCount}/${headcount.expectedCount} ACCOUNTED FOR" : "ALERT: ${headcount.missingCount} MISSING",
                      style: TextStyle(color: headcount.isAllAccountedFor ? LcarsTheme.greenSuccess : LcarsTheme.amberPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Text("COPPA / FERPA: Zero PII Recorded", style: TextStyle(color: LcarsTheme.cyanSecondary, fontSize: 11)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: LcarsTheme.textPrimary),
                      onPressed: () {
                        if (headcount.boardedCount > 0) {
                          setState(() {
                            headcount = headcount.copyWith(boardedCount: headcount.boardedCount - 1);
                          });
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: LcarsTheme.amberPrimary),
                      onPressed: () {
                        if (headcount.boardedCount < headcount.expectedCount) {
                          setState(() {
                            headcount = headcount.copyWith(boardedCount: headcount.boardedCount + 1);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Citizen Science Fundraiser HUD (Zooniverse / SciStarter)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: LcarsTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: LcarsTheme.greenSuccess.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🔬 CITIZEN SCIENCE QUEST & FUNDRAISER", style: TextStyle(color: LcarsTheme.greenSuccess, fontSize: 11, fontWeight: FontWeight.bold)),
                        Text("Zooniverse: Snapshot USA Wildlife", style: TextStyle(color: LcarsTheme.textPrimary, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: LcarsTheme.greenSuccess, foregroundColor: Colors.black),
                      onPressed: () {
                        setState(() {
                          citizenSciCount = (citizenSciCount + 5).clamp(0, 100);
                        });
                      },
                      child: const Text("+5 Quests", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: citizenSciCount / 100.0,
                  backgroundColor: LcarsTheme.surfaceVariant,
                  valueColor: const AlwaysStoppedAnimation(LcarsTheme.greenSuccess),
                  minHeight: 6,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$citizenSciCount/100 Classifications", style: const TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                    Text("+\$${earnedGrantOffset.toStringAsFixed(2)} Micro-Grant Offset", style: const TextStyle(color: LcarsTheme.greenSuccess, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Return Time & Net Cost Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: LcarsTheme.surfaceDark,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text("RETURN TIME", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                    Text(
                      SchoolBusVrpOptimizer.formatMinutesToClock(tripPlan.estimatedReturnTimeMinutes),
                      style: TextStyle(color: tripPlan.isBeforeDismissalBell ? LcarsTheme.greenSuccess : LcarsTheme.redAlert, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Bell Buffer: ${tripPlan.marginMinutesBeforeBell}m", style: const TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                  ],
                ),
                Column(
                  children: [
                    const Text("NET TRIP COST", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11)),
                    Text("\$${tripPlan.budget.netTotalCost.toStringAsFixed(2)}", style: const TextStyle(color: LcarsTheme.amberGlow, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("\$${tripPlan.budget.costPerStudent.toStringAsFixed(2)} / student", style: const TextStyle(color: LcarsTheme.amberPrimary, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Text("TEACHABLE STOPS & INTERCOM PROMPTS", style: TextStyle(color: LcarsTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          ...tripPlan.itinerary.map((stop) => Card(
            color: LcarsTheme.surfaceVariant,
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(stop.waypoint.name, style: const TextStyle(color: LcarsTheme.textPrimary, fontWeight: FontWeight.bold)),
                      Text("${SchoolBusVrpOptimizer.formatMinutesToClock(stop.arrivalTimeMin)} - ${SchoolBusVrpOptimizer.formatMinutesToClock(stop.departureTimeMin)}", style: const TextStyle(color: LcarsTheme.cyanSecondary, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text("🚌 ${stop.waypoint.parkingBusZoneInfo}", style: const TextStyle(color: LcarsTheme.amberGlow, fontSize: 12)),
                  if (stop.waypoint.teachableMoment != null) ...[
                    const SizedBox(height: 6),
                    Text("🎙️ TEACHABLE PROMPT: ${stop.waypoint.teachableMoment!.topic}", style: const TextStyle(color: LcarsTheme.greenSuccess, fontSize: 11, fontWeight: FontWeight.bold)),
                    Text(stop.waypoint.teachableMoment!.intercomDiscussionPrompt, style: const TextStyle(color: LcarsTheme.textPrimary, fontSize: 12)),
                  ],
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
