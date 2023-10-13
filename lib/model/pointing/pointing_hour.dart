import 'package:uuid/uuid.dart';

enum PointingType {
  inPointing,
  outPointing
}

class PointingHour {
  PointingHour({required this.idPointing, required this.typeOfPointing});

  final String id = const Uuid().v4();
  final DateTime hour = DateTime.now();
  final String idPointing;
  final PointingType typeOfPointing;
}