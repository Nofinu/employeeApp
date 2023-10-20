import 'package:tracker_app/model/messageModel/message.dart';

enum Priority { low, medium, high }
enum Privacy { public, private}

class Probleme extends Message {
  Probleme(
      {required super.title,
      required super.detail,
      required super.dateWritting,
      required super.writter,
      required this.priority,
      required this.privacy});

  final Priority priority;
  final Privacy privacy;

}
