
import 'package:intl/intl.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/message.dart';

final DateFormat formater = DateFormat.Md();

class Overtime extends Message{
  Overtime({super.id,
    required super.title,
      required super.detail,
      required super.dateWriting,
      required super.writer,
      super.isView,
      super.isvalidated,
      super.isCheked,
      required this.nbrHours,
      required this.dateOvertime});

  final double nbrHours;
  final DateTime dateOvertime;


  String getOvertimeDate() {
    return formater.format(dateOvertime);
  }

      factory Overtime.fromJson(Map<String, dynamic> json) {
    return Overtime(
        id : json['id'] as String ,
        title : json['title'] as String,
        detail : json['detail'] as String,
        writer : user[json['writer'] as int],
        dateWriting: DateTime.fromMillisecondsSinceEpoch(json['dateWriting'] as int),
        nbrHours: json['nbrHours'] as double,
        dateOvertime: DateTime.fromMillisecondsSinceEpoch(json['dateOvertime'] as int),
        isView: json['view'] as bool,
        isvalidated: json['validated'] as bool,
        isCheked: json['checked'] as bool
     );
  }
}
