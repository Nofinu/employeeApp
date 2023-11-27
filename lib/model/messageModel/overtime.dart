
import 'package:intl/intl.dart';
import 'package:tracker_app/model/messageModel/message.dart';

final DateFormat formater = DateFormat.Md();

class Overtime extends Message{
  Overtime({super.id,
    required super.title,
      required super.detail,
      required super.dateWriting,
      required super.writer,
      required this.nbrHours,
      required this.dateOvertime});

  final int nbrHours;
  final DateTime dateOvertime;


  String getOvertimeDate() {
    return formater.format(dateOvertime);
  }
}
