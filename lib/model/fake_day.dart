import 'package:intl/intl.dart';
import 'package:tracker_app/model/user.dart';

final DateFormat formater = DateFormat.Md();

enum TypeOfWork {
  dev,
  preparation,
  cours,
  formation,
  none,
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
}
