import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class User {
  User({@required this.uid});

  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;

  Future<User> currentUser();

  Future<User> signInAnonymously();

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<User> signInWithEmail(String email, String password);

  Future<User> createUserWithEmail(String email, String password);

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userUid(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userUid);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userUid(user);
  }

  @override
  Future<User> signInAnonymously() async {
    final auth_result = await _firebaseAuth.signInAnonymously();
    return _userUid(auth_result.user);
  }

  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(["public_profile"]);
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth
          .signInWithCredential(FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token,
      ));
      return _userUid(authResult.user);
    } else {
      print("Missing token");
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    try {
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if (googleAuth.idToken != null && googleAuth.accessToken != null) {
          final authResult = await _firebaseAuth.signInWithCredential(
              GoogleAuthProvider.getCredential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          return _userUid(authResult.user);
        } else {
          print("Missing Token");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<User> signInWithEmail(String email, String password) async{
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userUid(authResult.user);
  }

  @override
  Future<User> createUserWithEmail(String email, String password) async{
    // TODO: implement createUserWithEmail
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userUid(authResult.user);
  }
  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    _userUid(null);

    await _firebaseAuth.signOut();
  }


}
