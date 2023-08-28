import 'dart:convert';
import 'dart:developer';

import '../models/chat_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String backendUrl =
      "https://uc27krdoeht6u2rtr36q4azwke0huuoa.lambda-url.us-east-1.on.aws/";

  // Send message to the backend API
  static Future<ChatModel> sendMessage(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      //await Future.delayed(const Duration(seconds: 5));
      var response = await http.post(
        Uri.parse(backendUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "message": message,
        }),
      );

      //Map jsonResponse = jsonDecode(response.body);
      //Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return ChatModel(
        msg: utf8.decode(response.bodyBytes),
        chatIndex: 1,
      );
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
