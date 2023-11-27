import 'package:intl/intl.dart';
import 'package:tracker_app/model/messageModel/message.dart';

final DateFormat formater = DateFormat.yMMMMd();

class Request extends Message {
  Request(
      {super.id,
        required super.title,
      required super.detail,
      required super.writer,
      super.isCheked,
      super.isvalidated,
      required super.dateWriting,
      required this.requestDate});

  final DateTime requestDate;

  String getRequestDate() {
    return formater.format(requestDate);
  }
}
