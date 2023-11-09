import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/problem.dart';

class ProblemeNotifier extends StateNotifier<List<Probleme>> {
  ProblemeNotifier() : super(getProblemes());

  void setValidationOnRequest(Probleme message, bool validation) {
    List<Probleme> problemesList = [...state];
    if (problemesList.contains(message)) {
      int id = problemesList.indexOf(message);
      message.setIsChecked();
      message.setIsValidated(validation);
      problemesList.replaceRange(id, id + 1, [message]);
    }
    state = problemesList;
  }

  void addMessage(Probleme probleme) {
    List<Probleme> problemesList = [...state];
    problemesList.add(probleme);
    problemesList
        .sort((a, b) => -1 * (a.dateWriting.compareTo(b.dateWriting)));
    state = problemesList;
  }

  void setViewMessage(Probleme probleme) {
    List<Probleme> problemesList = [...state];
    if (problemesList.contains(probleme)) {
      int index = problemesList.indexOf(probleme);
      problemesList[index].setIsView();
    }
    state = problemesList;
  }
}

final problemeProvider =
    StateNotifierProvider<ProblemeNotifier, List<Probleme>>(
        (ref) => ProblemeNotifier());
