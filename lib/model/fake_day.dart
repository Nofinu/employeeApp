
import 'package:tracker_app/model/user.dart';

enum TypeOfWork{
  dev,
  preparation,
  cours,
  formation,
  none,
}

class FakeDay {
  const FakeDay ({required this.type,required this.repos, this.formation,required this.users});
  final TypeOfWork type;
  final bool repos;
  final String? formation;
  final List<User> users;
}