import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/Request.dart';
import 'package:tracker_app/model/messageModel/message.dart';

class MessageNotifier extends StateNotifier<List<Message>> {
  MessageNotifier() : super(getMessages());

    void setMessages (List<Message> messages){
    state = messages;
  }

  void setValidationOnRequest(Request message, bool validation) {
    List<Message> copyMessage = state;
    if(state.contains(message)){
      int id = state.indexOf(message);
      message.setIsChecked();
      message.setIsValidated(validation);
      copyMessage.replaceRange(id, id+1, [message]);
      state = copyMessage;
    }
  }

  void addMessage (Message message){
    List<Message> copyMessage = state;
    copyMessage.add(message);
    copyMessage.sort((a,b)=> -1*(a.dateWritting.compareTo(b.dateWritting)));
    state = copyMessage;
  }
}

final messageProvider = StateNotifierProvider<MessageNotifier, List<Message>>(
    (ref) => MessageNotifier());
