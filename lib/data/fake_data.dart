import 'dart:math';

import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/fake_day.dart';

final user = [
  User(
      0,
      "Mohamed",
      "AIJJOU",
      "https://utopios.solutions/wp-content/uploads/2023/09/Mohamed_AIJJOU.webp",
      false,
      "mohamed"),
  User(
      1,
      "Marine",
      "ABADI",
      "https://utopios.solutions/wp-content/uploads/2023/09/Marine_ABADI.webp",
      true,
      "marine"),
  User(
      2,
      "Ihab",
      "ABADI",
      "https://utopios.solutions/wp-content/uploads/2023/09/Ihab_ABADI-1.webp",
      false,
      "ihab"),
  User(
      3,
      "Antoine ",
      "DIEUDONNE",
      "https://utopios.solutions/wp-content/uploads/2023/09/Antoine_DIEUDONNE.webp",
      false,
      "antoine"),
  User(
    4,
    "Guillaume ",
    "MAIRESSE",
    "https://utopios.solutions/wp-content/uploads/2023/09/Guillaume_MAIRESSE.webp",
    false,
    "guillaume",
  ),
  User(
      5,
      "Christophe ",
      "DELORY",
      "https://utopios.solutions/wp-content/uploads/2023/09/Christophe_DELORY.webp",
      false,
      "christopheD"),
  User(
      6,
      "Arthur ",
      "DENNETIERE",
      "https://utopios.solutions/wp-content/uploads/2023/09/Arthur_DENNETIERE.webp",
      false,
      "arthur"),
  User(
      7,
      "Christophe ",
      "RINGOT",
      "https://utopios.solutions/wp-content/uploads/2023/09/Christophe_RINGOT.webp",
      false,
      "christopheR"),
  User(
    8,
    "Margot ",
    "LAIGNEZ",
    "https://utopios.solutions/wp-content/uploads/2023/09/Margot.webp",
    false,
    "margot",
  ),
  User(
      9,
      "Benoit ",
      "LECOEUVRE",
      "https://utopios.solutions/wp-content/uploads/2023/09/Benoit_LECOEUVRE.webp",
      false,
      "benoit")
];

List<User> getListUsers(int nbrUsers) {
  List<User> usersList = [];
  for (int i = 0; i < nbrUsers; i++) {
    usersList.add(user[Random().nextInt(user.length)]);
  }
  return usersList;
}

List<FakeDay> semaine = [
  FakeDay(
    type: TypeOfWork.formation,
    repos: false,
    formation: "M2i",
    users: getListUsers(3),
    date: DateTime.utc(2023, 10, 16),
  ),
  FakeDay(
    type: TypeOfWork.cours,
    repos: false,
    users: getListUsers(2),
    date: DateTime.utc(2023, 10, 17),
  ),
  FakeDay(
    type: TypeOfWork.none,
    repos: true,
    users: getListUsers(4),
    date: DateTime.utc(2023, 10, 18),
  ),
  FakeDay(
    type: TypeOfWork.dev,
    repos: false,
    users: getListUsers(1),
    date: DateTime.utc(2023, 10, 19),
  ),
  FakeDay(
    type: TypeOfWork.preparation,
    repos: false,
    users: getListUsers(6),
    date: DateTime.utc(2023, 10, 20),
  ),
];
