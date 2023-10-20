import 'dart:math';

import 'package:tracker_app/Screen/probleme/form_problem.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/fake_day.dart';
import 'package:tracker_app/model/messageModel/request.dart';
import 'package:tracker_app/model/messageModel/problem.dart';
import 'package:tracker_app/model/pointing/pointing.dart';
import 'package:tracker_app/model/pointing/pointing_hour.dart';

const loginData = {"email": "toto@gmail.com", "password": "toto"};

const user = [
  User(
      "Mohamed",
      "AIJJOU",
      "https://utopios.solutions/wp-content/uploads/2023/09/Mohamed_AIJJOU.webp",
      false,
      "mohamed",
      "123"),
  User(
      "Marine ",
      "ABADI",
      "https://utopios.solutions/wp-content/uploads/2023/09/Marine_ABADI.webp",
      true,
      "marine",
      "123"),
  User(
      "Ihab",
      "ABADI",
      "https://utopios.solutions/wp-content/uploads/2023/09/Ihab_ABADI-1.webp",
      false,
      "ihab",
      "123"),
  User(
      "Antoine ",
      "DIEUDONNE",
      "https://utopios.solutions/wp-content/uploads/2023/09/Antoine_DIEUDONNE.webp",
      false,
      "antoine",
      "123"),
  User(
      "Guillaume ",
      "MAIRESSE",
      "https://utopios.solutions/wp-content/uploads/2023/09/Guillaume_MAIRESSE.webp",
      false,
      "guillaume",
      "123"),
  User(
      "Christophe ",
      "DELORY",
      "https://utopios.solutions/wp-content/uploads/2023/09/Christophe_DELORY.webp",
      false,
      "christopheD",
      "123"),
  User(
      "Arthur ",
      "DENNETIERE",
      "https://utopios.solutions/wp-content/uploads/2023/09/Arthur_DENNETIERE.webp",
      false,
      "arthur",
      "123"),
  User(
      "Christophe ",
      "RINGOT",
      "https://utopios.solutions/wp-content/uploads/2023/09/Christophe_RINGOT.webp",
      false,
      "christopheR",
      "123"),
  User(
      "Margot ",
      "LAIGNEZ",
      "https://utopios.solutions/wp-content/uploads/2023/09/Margot.webp",
      false,
      "margot",
      "123"),
  User(
      "Benoit ",
      "LECOEUVRE",
      "https://utopios.solutions/wp-content/uploads/2023/09/Benoit_LECOEUVRE.webp",
      false,
      "benoit",
      "123")
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
      users: getListUsers(3)),
  FakeDay(type: TypeOfWork.cours, repos: false, users: getListUsers(2)),
  FakeDay(type: TypeOfWork.none, repos: true, users: getListUsers(4)),
  FakeDay(type: TypeOfWork.dev, repos: false, users: getListUsers(1)),
  FakeDay(type: TypeOfWork.preparation, repos: false, users: getListUsers(6)),
];

final List<Probleme> problemeList= [
  Probleme(
    title: "probleme1",
    detail: "ceci est un premier probleme",
    dateWritting: DateTime.now(),
    writter: user[0],
    priority: Priority.low,
    privacy: Privacy.public
  ),
  Probleme(
    title: "probleme2",
    detail: "ceci est un premier probleme",
    dateWritting: DateTime(2022, 10, 2, 15, 30, 0),
    writter: user[3],
    priority: Priority.medium,
    privacy: Privacy.private
  ),
  Probleme(
    title: "probleme3",
    detail: "ceci est un premier probleme",
    dateWritting: DateTime(2023, 10, 2, 16, 30, 0),
    writter: user[2],
    priority: Priority.high,
    privacy: Privacy.public
  ),
];

List<Probleme> getProblemes (){
  List<Probleme> problemeListcopy = problemeList;
  problemeListcopy.sort((a, b) => -1 * (a.dateWritting.compareTo(b.dateWritting)));
  return problemeListcopy;
}

List<Request> requestList = [
    Request(
      title: "Request 1",
      detail: "ceci est une request",
      dateWritting: DateTime(2023, 10, 2, 11, 30, 0),
      writter: user[0],
      requestDate: DateTime(2024, 10, 2, 11, 30, 0)),
    Request(
      title: "Request 2",
      detail: "ceci est une request",
      dateWritting: DateTime(2023, 11, 2, 11, 30, 0),
      writter: user[5],
      requestDate: DateTime(2024, 10, 2, 11, 30, 0),
      isCheked: true,
      isvalidated: false),
];

List<Request> getRequest (){
  List<Request> requestListcopy = requestList;
  requestListcopy.sort((a, b) => -1 * (a.dateWritting.compareTo(b.dateWritting)));
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
