import 'dart:convert';
import 'dart:developer';

import '../models/chat_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String backendUrl =
      "https://uhxn2xkeogpo75qszgolc2cffu0hrtcc.lambda-url.ap-southeast-1.on.aws/";

  // Send message to the backend API
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        Uri.parse(backendUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "message": message,
        }),
      );

      //Map jsonResponse = jsonDecode(response.body);
      //Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<ChatModel> chatList = [
        ChatModel(
          msg: utf8.decode(response.bodyBytes),
          chatIndex: 1,
        ),
      ];
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
