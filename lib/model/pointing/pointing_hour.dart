import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final DateFormat formater = DateFormat.Hm();

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

String getHours (){
  return formater.format(hour);
}
}