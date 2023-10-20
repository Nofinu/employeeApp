import 'package:tracker_app/Screen/messageBox/report_problem.dart';
import 'package:tracker_app/model/messageModel/message.dart';


class Probleme extends Message {
  Probleme(
      {required super.title,
      required super.detail,
      required super.dateWritting,
      required super.writter,
      required this.priority});

  final Priority priority;

}
