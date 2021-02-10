import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

void fbLogin() async {
  final facebookLogin = FacebookLogin();
  final facebookLoginResult = await facebookLogin.logIn(['email']);

  print(facebookLoginResult.accessToken);
  print(facebookLoginResult.accessToken.token);
  print(facebookLoginResult.accessToken.expires);
  print(facebookLoginResult.accessToken.permissions);
  print(facebookLoginResult.accessToken.userId);
  print(facebookLoginResult.accessToken.isValid());

  print(facebookLoginResult.errorMessage);
  print(facebookLoginResult.status);

  final token = facebookLoginResult.accessToken.token;

  /// for profile details also use the below code
  final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
  final profile = json.decode(graphResponse.body);
  print(profile);
  /*
    from profile you will get the below params
    {
     "name": "Iiro Krankka",
     "first_name": "Iiro",
     "last_name": "Krankka",
     "email": "iiro.krankka\u0040gmail.com",
     "id": "<user id here>"
    }
   */
}
