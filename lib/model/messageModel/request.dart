import 'package:intl/intl.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/message.dart';

final DateFormat formater = DateFormat.yMMMMd();

class Request extends Message {
  Request(
      {super.id,
        required super.title,
      required super.detail,
      required super.writer,
      super.isCheked,
      super.isView,
      super.isvalidated,
      required super.dateWriting,
      required this.requestDate});

  final DateTime requestDate;

  String getRequestDate() {
    return formater.format(requestDate);
  }

      factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        id : json['id'] as String ,
        title : json['title'] as String,
        detail : json['detail'] as String,
        writer : user[json['writer'] as int],
        dateWriting: DateTime.fromMillisecondsSinceEpoch(json['dateWriting'] as int),
        requestDate: DateTime.fromMillisecondsSinceEpoch(json['requestDate'] as int),
        isView: json['view'] as bool,
        isvalidated: json['validated'] as bool,
        isCheked: json['checked'] as bool
     );
  }
}
