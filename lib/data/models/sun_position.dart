class SunPosition {
  final double azimuthDegrees;
  final double elevationDegrees;
  final double zenithDegrees;
  final String phase;

  const SunPosition({
    required this.azimuthDegrees,
    required this.elevationDegrees,
    required this.zenithDegrees,
    required this.phase,
  });
}
