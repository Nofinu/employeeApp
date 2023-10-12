import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/request.dart';
import 'package:tracker_app/model/messageModel/message.dart';


class MessageNotifier extends ChangeNotifier {
  List<Message> messages = getMessages();

  void setValidationOnRequest(Request message, bool validation) {
    if (messages.contains(message)) {
      int id = messages.indexOf(message);
      message.setIsChecked();
      message.setIsValidated(validation);
      messages.replaceRange(id, id + 1, [message]);
      notifyListeners();
    }
  }

  void addMessage(Message message) {
    messages.add(message);
    messages.sort((a, b) => -1 * (a.dateWritting.compareTo(b.dateWritting)));
    notifyListeners();
  }

  int getNotification() {
    int cpt = 0;
    for (int i = 0; i < messages.length; i++) {
      if (!messages[i].isView) {
        cpt++;
      }
    }
    return cpt;
  }

  void setViewMessage(Message message) {
    if (messages.contains(message)) {
      int index = messages.indexOf(message);
      messages[index].setIsView();
      notifyListeners();
    }
  }

}

final messageProvider = ChangeNotifierProvider<MessageNotifier>((ref) => MessageNotifier());
