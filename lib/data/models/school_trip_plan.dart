class AnonymousHeadcount {
  final int expectedCount;
  final int boardedCount;
  final DateTime? lastVerifiedTime;

  const AnonymousHeadcount({
    required this.expectedCount,
    this.boardedCount = 0,
    this.lastVerifiedTime,
  });

  bool get isAllAccountedFor => boardedCount == expectedCount;
  int get missingCount => (expectedCount - boardedCount).clamp(0, expectedCount);

  AnonymousHeadcount copyWith({int? boardedCount, DateTime? lastVerifiedTime}) {
    return AnonymousHeadcount(
      expectedCount: expectedCount,
      boardedCount: boardedCount ?? this.boardedCount,
      lastVerifiedTime: lastVerifiedTime ?? this.lastVerifiedTime,
    );
  }
}

class CitizenScienceProject {
  final String id;
  final String name;
  final String platform; // Zooniverse, SciStarter, iNaturalist, NASA GLOBE
  final String taskDescription;
  final int completedCount;
  final int targetCount;
  final double microGrantPerUnit;
  final String sponsorName;
  final String projectUrl;

  const CitizenScienceProject({
    required this.id,
    required this.name,
    required this.platform,
    required this.taskDescription,
    this.completedCount = 0,
    this.targetCount = 100,
    this.microGrantPerUnit = 0.50,
    this.sponsorName = "STEM Community Fund",
    this.projectUrl = "https://www.zooniverse.org",
  });

  double get earnedFunding => completedCount * microGrantPerUnit;
  double get progressPercent => targetCount > 0 ? (completedCount / targetCount).clamp(0.0, 1.0) : 0.0;

  CitizenScienceProject copyWith({int? completedCount}) {
    return CitizenScienceProject(
      id: id,
      name: name,
      platform: platform,
      taskDescription: taskDescription,
      completedCount: completedCount ?? this.completedCount,
      targetCount: targetCount,
      microGrantPerUnit: microGrantPerUnit,
      sponsorName: sponsorName,
      projectUrl: projectUrl,
    );
  }
}

class SchoolBusBudget {
  final double fuelPricePerGallon;
  final double busMpg;
  final double driverHourlyRate;
  final double admissionFeePerStudent;
  final double totalMiles;
  final double totalHours;
  final int studentCount;
  final double citizenScienceFundingOffset;

  const SchoolBusBudget({
    this.fuelPricePerGallon = 4.25,
    this.busMpg = 7.5,
    this.driverHourlyRate = 28.50,
    this.admissionFeePerStudent = 8.00,
    this.totalMiles = 0.0,
    this.totalHours = 0.0,
    this.studentCount = 28,
    this.citizenScienceFundingOffset = 0.0,
  });

  double get estimatedFuelCost => (totalMiles / busMpg) * fuelPricePerGallon;
  double get estimatedDriverCost => totalHours * driverHourlyRate;
  double get totalAdmissionCost => studentCount * admissionFeePerStudent;
  double get grandTotalCost => estimatedFuelCost + estimatedDriverCost + totalAdmissionCost;
  double get netTotalCost => (grandTotalCost - citizenScienceFundingOffset).clamp(0.0, double.infinity);
  double get costPerStudent => studentCount > 0 ? netTotalCost / studentCount : 0.0;
}

class TeachableMoment {
  final String topic;
  final String subjectArea;
  final String intercomDiscussionPrompt;

  const TeachableMoment({
    required this.topic,
    required this.subjectArea,
    required this.intercomDiscussionPrompt,
  });
}

class SchoolFieldTripWaypoint {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final int bookedTimeWindowStartMin;
  final int bookedTimeWindowEndMin;
  final String parkingBusZoneInfo;
  final TeachableMoment? teachableMoment;
  final CitizenScienceProject? citizenScienceProject;

  const SchoolFieldTripWaypoint({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.bookedTimeWindowStartMin,
    required this.bookedTimeWindowEndMin,
    required this.parkingBusZoneInfo,
    this.teachableMoment,
    this.citizenScienceProject,
  });
}
