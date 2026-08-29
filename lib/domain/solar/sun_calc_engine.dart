import 'dart:math' as math;
import '../../data/models/sun_position.dart';

class SunCalcEngine {
  static const double rad = math.pi / 180.0;
  static const double deg = 180.0 / math.pi;

  static SunPosition calculatePosition(DateTime date, double lat, double lng) {
    final double dayOfYear = _getDayOfYear(date).toDouble();
    final double hourOfDay = date.hour + date.minute / 60.0 + date.second / 3600.0;

    // Solar Declination
    final double b = (360.0 / 365.0) * (dayOfYear - 81.0) * rad;
    final double eot = 9.87 * math.sin(2.0 * b) - 7.53 * math.cos(b) - 1.5 * math.sin(b);
    final double timeOffset = eot + 4.0 * lng - 60.0 * date.timeZoneOffset.inHours;
    final double tst = hourOfDay * 60.0 + timeOffset;

    final double solarHourAngle = (tst / 4.0 - 180.0) * rad;
    final double solarDeclination = 23.45 * math.sin(b) * rad;

    final double latRad = lat * rad;
    final double sinElevation = math.sin(latRad) * math.sin(solarDeclination) +
        math.cos(latRad) * math.cos(solarDeclination) * math.cos(solarHourAngle);
    final double elevationRad = math.asin(sinElevation.clamp(-1.0, 1.0));

    final double cosAzimuth = (math.sin(solarDeclination) - math.sin(latRad) * math.sin(elevationRad)) /
        (math.cos(latRad) * math.cos(elevationRad)).clamp(0.0001, 1.0);
    double azimuthRad = math.acos(cosAzimuth.clamp(-1.0, 1.0));
    if (solarHourAngle > 0) azimuthRad = 2.0 * math.pi - azimuthRad;

    final double elevationDeg = elevationRad * deg;
    final double azimuthDeg = azimuthRad * deg;

    String phase = "Night";
    if (elevationDeg > 6.0) {
      phase = "Daylight";
    } else if (elevationDeg >= -4.0 && elevationDeg <= 6.0) {
      phase = "Golden Hour";
    } else if (elevationDeg >= -6.0 && elevationDeg < -4.0) {
      phase = "Blue Hour";
    } else if (elevationDeg >= -12.0 && elevationDeg < -6.0) {
      phase = "Nautical Twilight";
    } else if (elevationDeg >= -18.0 && elevationDeg < -12.0) {
      phase = "Astronomical Twilight";
    }

    return SunPosition(
      azimuthDegrees: (azimuthDeg + 360.0) % 360.0,
      elevationDegrees: elevationDeg,
      zenithDegrees: 90.0 - elevationDeg,
      phase: phase,
    );
  }

  static int _getDayOfYear(DateTime date) {
    return date.difference(DateTime(date.year, 1, 1)).inDays + 1;
  }
}
