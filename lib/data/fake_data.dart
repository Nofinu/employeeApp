
import 'package:tracker_app/Screen/report_problem.dart';
import 'package:tracker_app/model/User.dart';
import 'package:tracker_app/model/fake_day.dart';
import 'package:tracker_app/model/messageModel/Request.dart';
import 'package:tracker_app/model/messageModel/message.dart';
import 'package:tracker_app/model/messageModel/problem.dart';

const loginData = {
  "email" :  "toto@gmail.com",
  "password": "toto"
};

const user = [
  User("Mohamed", "AIJJOU", "https://utopios.solutions/wp-content/uploads/2023/09/Mohamed_AIJJOU.webp",false,"mohamed","123"),
  User("Marine ", "ABADI", "https://utopios.solutions/wp-content/uploads/2023/09/Marine_ABADI.webp",true,"marine","123")
];

const semaine =[
  FakeDay(type: TypeOfWork.formation, repos: false,formation: "M2i",nbrPerson: 3),
  FakeDay(type: TypeOfWork.cours, repos: false,nbrPerson: 2),
  FakeDay(type: TypeOfWork.none, repos: true,nbrPerson: 4),
  FakeDay(type: TypeOfWork.dev, repos: false,nbrPerson: 1),
  FakeDay(type: TypeOfWork.preparation, repos: false,nbrPerson: 6),
];

final messages = [
  Probleme(title: "probleme1", detail: "ceci est un premier probleme", dateWritting: DateTime.now(), writter: user[0], priority: Priority.low,),
  Probleme(title: "probleme2", detail: "ceci est un premier probleme", dateWritting: DateTime(2022,10,2,15,30,0), writter: user[1], priority: Priority.medium,),
  Request(title: "Request 1", detail: "ceci est une request", dateWritting: DateTime(2023,10,2,11,30,0), writter: user[0],requestDate: DateTime(2024  ,10,2,11,30,0)),
  Probleme(title: "probleme3", detail: "ceci est un premier probleme", dateWritting: DateTime(2023,10,2,16,30,0), writter: user[1], priority: Priority.high,),
  Request(title: "Request 1", detail: "ceci est une request", dateWritting: DateTime(2023,10,2,11,30,0), writter: user[0],requestDate: DateTime(2024  ,10,2,11,30,0),isCheked: true,isvalidated: true  ),
];

List<Message> getMessages (){
  final messageSort = messages;
  messageSort.sort((a,b)=> -1*(a.dateWritting.compareTo(b.dateWritting)));
  return messageSort;
}