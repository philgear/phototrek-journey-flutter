enum Category {
  coastal,
  desert,
  mountain,
  forest,
  urban,
  nightSky
}

class Waypoint {
  final String id;
  final String name;
  final String state;
  final double lat;
  final double lng;
  final double elevationFeet;
  final Category category;
  final String targetLightPhase;
  final int idealTimeMin; // Minutes from midnight (e.g. 360 = 06:00 AM)
  final int windowStartMin;
  final int windowEndMin;
  final int serviceDurationMinutes;
  final String recommendedFocalLength;
  final String compositionTip;
  final String geologicalNote;
  final String placeId;
  final bool isVisited;

  const Waypoint({
    required this.id,
    required this.name,
    required this.state,
    required this.lat,
    required this.lng,
    required this.elevationFeet,
    required this.category,
    required this.targetLightPhase,
    required this.idealTimeMin,
    required this.windowStartMin,
    required this.windowEndMin,
    required this.serviceDurationMinutes,
    required this.recommendedFocalLength,
    required this.compositionTip,
    required this.geologicalNote,
    this.placeId = '',
    this.isVisited = false,
  });

  Waypoint copyWith({bool? isVisited}) {
    return Waypoint(
      id: id,
      name: name,
      state: state,
      lat: lat,
      lng: lng,
      elevationFeet: elevationFeet,
      category: category,
      targetLightPhase: targetLightPhase,
      idealTimeMin: idealTimeMin,
      windowStartMin: windowStartMin,
      windowEndMin: windowEndMin,
      serviceDurationMinutes: serviceDurationMinutes,
      recommendedFocalLength: recommendedFocalLength,
      compositionTip: compositionTip,
      geologicalNote: geologicalNote,
      placeId: placeId,
      isVisited: isVisited ?? this.isVisited,
    );
  }
}
