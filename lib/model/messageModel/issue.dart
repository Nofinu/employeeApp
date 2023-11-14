import 'package:tracker_app/model/messageModel/message.dart';

enum Priority { low, medium, high }

enum Privacy { public, private }

class Issue extends Message {
  Issue(
      {required super.title,
      required super.detail,
      required super.dateWriting,
      required super.writer,
      super.isCheked,
      super.isvalidated,
      required this.priority,
      required this.privacy});

  final Priority priority;
  final Privacy privacy;

}
