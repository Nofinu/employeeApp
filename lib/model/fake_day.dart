import 'package:intl/intl.dart';
import 'package:tracker_app/model/user.dart';

final DateFormat formater = DateFormat.Md();

enum TypeOfWork {
  dev,
  preparation,
  cours,
  formation,
  repos,
}

class FakeDay {
  const FakeDay(
      {required this.type,
      required this.repos,
      this.formation,
      required this.users,
      required this.date});
  final DateTime date;
  final TypeOfWork type;
  final bool repos;
  final String? formation;
  final List<User> users;

  String getDate() {
    return formater.format(date);
  }

    factory FakeDay.fromJson(Map<String, dynamic> json) {
    return FakeDay(
        date : DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
        type : json['type'] as String == "formation"? TypeOfWork.formation : json['type'] as String == "dev"? TypeOfWork.dev : json['type'] as String == "cours" ? TypeOfWork.cours : json['type'] as String == "preparation"? TypeOfWork.preparation : TypeOfWork.repos,
        repos: json['repos'] as bool,
        formation: json['formation'] as String,
        users: List<User>.from((json['users'] as List<dynamic>)
          .map<User>((value) => User.fromJson(value))
          .toList())
          );
  }
}
