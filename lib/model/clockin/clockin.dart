import 'package:intl/intl.dart';

final DateFormat formater = DateFormat.Hm();
final DateFormat formaterDate = DateFormat.yMMMd();

class Clockin {
  Clockin({required this.id, required this.userId, required this.clockInHour , this.clockOutHour});

  final String id ;
  final int userId;
  final DateTime clockInHour;
  final DateTime? clockOutHour;
  


String getClockInHour(){
  return formater.format(clockInHour);
}
String getClockOutHour(){
  if(clockOutHour != null){
      return formater.format(clockOutHour!);
  }
  return "";
}
String getDateClockin (){
  return formaterDate.format(clockInHour);
}

  factory Clockin.fromJson(Map<String, dynamic> json) {
    return Clockin(
        id: json['id'] as String,
        userId: json['userId'] as int,
        clockInHour: DateTime.fromMillisecondsSinceEpoch(json['clockInHour'] as int),
        clockOutHour: json['clockOutHour'] != null ? DateTime.fromMillisecondsSinceEpoch(json['clockOutHour'] as int) : null,
        );
  }

}