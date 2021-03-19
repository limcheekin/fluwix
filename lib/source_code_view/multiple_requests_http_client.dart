import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MultipleRequestsHttpClient {
  final Client client = http.Client();
  int requestCount = 0;

  MultipleRequestsHttpClient();

  Future<Response> get(Uri url, {Map<String, String> headers}) {
    ++requestCount;
    return client.get(url, headers: headers);
  }

  void close() {
    --requestCount;
    // print('requestCount $requestCount');
    if (requestCount == 0) {
      client.close();
      print('client connection closed');
    }
  }
}
