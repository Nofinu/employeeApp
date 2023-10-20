import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/problem.dart';


class ProblemeNotifier extends ChangeNotifier {
  List<Probleme> problemesList = getProblemes();

  // void setValidationOnRequest(Request message, bool validation) {
  //   if (messages.contains(message)) {
  //     int id = messages.indexOf(message);
  //     message.setIsChecked();
  //     message.setIsValidated(validation);
  //     messages.replaceRange(id, id + 1, [message]);
  //     notifyListeners();
  //   }
  // }

  void addMessage(Probleme probleme) {
    problemesList.add(probleme);
    problemesList.sort((a, b) => -1 * (a.dateWritting.compareTo(b.dateWritting)));
    notifyListeners();
  }

  int getNotification() {
    int cpt = 0;
    for (int i = 0; i < problemesList.length; i++) {
      if (!problemesList[i].isView) {
        cpt++;
      }
    }
    return cpt;
  }

  void setViewMessage(Probleme probleme) {
    if (problemesList.contains(probleme)) {
      int index = problemesList.indexOf(probleme);
      problemesList[index].setIsView();
      notifyListeners();
    }
  }

}

final problemeProvider = ChangeNotifierProvider<ProblemeNotifier>((ref) => ProblemeNotifier());
