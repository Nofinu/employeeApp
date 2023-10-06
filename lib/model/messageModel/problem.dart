import 'package:tracker_app/Screen/report_problem.dart';
import 'package:tracker_app/widgets/probelem_message_item.dart';
import 'package:tracker_app/model/messageModel/message.dart';

class Probleme extends Message {
  const Probleme(
      {required super.title,
      required super.detail,
      required super.dateWritting,
      required super.writter,
      required this.priority});

  final Priority priority;

  @override
  ProbelemMessageItem showWidget (onClickValidationButton){
    return ProbelemMessageItem(probleme: this);
  }
}
