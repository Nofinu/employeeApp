import 'dart:math';

import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/fake_day.dart';
import 'package:tracker_app/model/messageModel/request.dart';
import 'package:tracker_app/model/messageModel/problem.dart';
import 'package:tracker_app/model/pointing/pointing.dart';
import 'package:tracker_app/model/pointing/pointing_hour.dart';

const loginData = {"email": "toto@gmail.com", "password": "toto"};

final user = [
  User(
      1,
      "Mohamed",
      "AIJJOU",
      "https://utopios.solutions/wp-content/uploads/2023/09/Mohamed_AIJJOU.webp",
      false,
      "mohamed"),
  User(
      2,
      "Marine ",
      "ABADI",
      "https://utopios.solutions/wp-content/uploads/2023/09/Marine_ABADI.webp",
      true,
      "marine"),
  User(
      3,
      "Ihab",
      "ABADI",
      "https://utopios.solutions/wp-content/uploads/2023/09/Ihab_ABADI-1.webp",
      false,
      "ihab"),
  User(
      4,
      "Antoine ",
      "DIEUDONNE",
      "https://utopios.solutions/wp-content/uploads/2023/09/Antoine_DIEUDONNE.webp",
      false,
      "antoine"),
  User(
    5,
    "Guillaume ",
    "MAIRESSE",
    "https://utopios.solutions/wp-content/uploads/2023/09/Guillaume_MAIRESSE.webp",
    false,
    "guillaume",
  ),
  User(
      6,
      "Christophe ",
      "DELORY",
      "https://utopios.solutions/wp-content/uploads/2023/09/Christophe_DELORY.webp",
      false,
      "christopheD"),
  User(
      7,
      "Arthur ",
      "DENNETIERE",
      "https://utopios.solutions/wp-content/uploads/2023/09/Arthur_DENNETIERE.webp",
      false,
      "arthur"),
  User(
      8,
      "Christophe ",
      "RINGOT",
      "https://utopios.solutions/wp-content/uploads/2023/09/Christophe_RINGOT.webp",
      false,
      "christopheR"),
  User(
    9,
    "Margot ",
    "LAIGNEZ",
    "https://utopios.solutions/wp-content/uploads/2023/09/Margot.webp",
    false,
    "margot",
  ),
  User(
      10,
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

final List<Probleme> problemeList = [
  Probleme(
      title: "probleme1",
      detail: "ceci est un premier probleme",
      dateWriting: DateTime.now(),
      writer: user[0],
      priority: Priority.low,
      privacy: Privacy.public),
  Probleme(
      title: "probleme2",
      detail: "ceci est un premier probleme",
      dateWriting: DateTime(2022, 10, 2, 15, 30, 0),
      writer: user[3],
      priority: Priority.medium,
      privacy: Privacy.private),
  Probleme(
      title: "probleme3",
      detail: "ceci est un premier probleme",
      dateWriting: DateTime(2023, 10, 2, 16, 30, 0),
      writer: user[2],
      priority: Priority.high,
      privacy: Privacy.public),
];

List<Probleme> getProblemes() {
  List<Probleme> problemeListcopy = problemeList;
  problemeListcopy
      .sort((a, b) => -1 * (a.dateWriting.compareTo(b.dateWriting)));
  return problemeListcopy;
}

List<Request> _requestList = [
  Request(
      title: "Request 1",
      detail: "ceci est une request",
      dateWriting: DateTime(2023, 10, 2, 11, 30, 0),
      writer: user[0],
      requestDate: DateTime(2024, 10, 2, 11, 30, 0)),
  Request(
      title: "Request 2",
      detail: "ceci est une request",
      dateWriting: DateTime(2023, 11, 2, 11, 30, 0),
      writer: user[5],
      requestDate: DateTime(2024, 10, 2, 11, 30, 0),
      isCheked: true,
      isvalidated: false),
];

List<Request> getRequest() {
  List<Request> requestListcopy = _requestList;
  requestListcopy.sort((a, b) => -1 * (a.dateWriting.compareTo(b.dateWriting)));
  return requestListcopy;
}

final pointingList = [
  Pointing(user: user[6], date: DateTime.now()),
  Pointing(user: user[4], date: DateTime.now()),
  Pointing(user: user[2], date: DateTime.now()),
  Pointing(user: user[3], date: DateTime.now()),
];

List<Pointing> getPointing() {
  pointingList.forEach((element) {
    element.addPointingHour(PointingType.inPointing);
  });
  return pointingList;
}
