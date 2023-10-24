
import 'package:intl/intl.dart';
import 'package:tracker_app/model/messageModel/message.dart';

final DateFormat formater = DateFormat.Md();

class Overtime extends Message{
  Overtime({required super.title,
      required super.detail,
      required super.dateWritting,
      required super.writter,
      required this.nbrHours,
      required this.dateOvertime});

  final int nbrHours;
  final DateTime dateOvertime;


  String getOvertimeDate() {
    return formater.format(dateOvertime);
  }
}
