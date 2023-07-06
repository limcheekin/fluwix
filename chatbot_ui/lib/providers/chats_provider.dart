import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/chat_model.dart';
import '../services/api_service.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    final response = await ApiService.sendMessage(
      message: msg,
      modelId: chosenModelId,
    );
    if (chatList.isEmpty) {
      chatList.add(response);
    } else {
      chatList.last = response;
    }

    notifyListeners();
  }
}
