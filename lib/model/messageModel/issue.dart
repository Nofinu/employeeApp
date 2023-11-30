import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/message.dart';

enum Priority { low, medium, high }

enum Privacy { public, private }

class Issue extends Message {
  Issue(
      {super.id,
        required super.title,
      required super.detail,
      required super.dateWriting,
      required super.writer,
      super.isView,
      super.isvalidated,
      required this.priority,
      required this.privacy});

  final Priority priority;
  final Privacy privacy;

    factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
        title : json['title'] as String,
        detail : json['detail'] as String,
        writer : user[json['writer'] as int],
        priority : json['priority'] as String == "low"? Priority.low : json['priority'] as String == "medium"? Priority.medium:Priority.high,
        privacy : json['privacy'] as String == "private" ? Privacy.private : Privacy.public,
        id : json['id'] as String ,
        isView: json['view'] as bool,
        isvalidated: json['validated'] as bool,
        dateWriting: DateTime.fromMillisecondsSinceEpoch(json['dateWriting'] as int)

     );
  }

}
