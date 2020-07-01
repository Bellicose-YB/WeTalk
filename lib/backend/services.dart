import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authmethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userfromFirebase(FirebaseUser user) {
    return user != null ? User(id: user.uid) : null;
  }

  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseuser = result.user;
      return _userfromFirebase(firebaseuser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signup(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseuser = result.user;
      return _userfromFirebase(firebaseuser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetpassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FirebaseUser> loginwithgoogle() async {
    try {
      GoogleSignIn googlesignin = GoogleSignIn();
      GoogleSignInAccount account = await googlesignin.signIn();
      if (account == null) return null;
      AuthResult result = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: (await account.authentication).idToken,
              accessToken: (await account.authentication).accessToken));
      if (result.user == null) return null;
      return result.user;
    } catch (e) {
      print("Error is: $e");
      return null;
    }
  }
}

class User {
  String id;
  User({this.id});
}
