import 'package:google_sign_in/google_sign_in.dart';

void googleLogin() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
    print(acc.id);
    print(acc.email);
    print(acc.displayName);
    print(acc.photoUrl);

    acc.authentication.then((GoogleSignInAuthentication auth) async {
      print(auth.idToken);
      print(auth.accessToken);
    });
  });
}
