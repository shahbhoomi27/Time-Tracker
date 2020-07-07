import 'package:flutter/material.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/widgets/MyRaisedButton.dart';
import 'package:time_tracker_app/screens/SignInEmailScreen.dart';

class SignInOption extends StatelessWidget {
  SignInOption({@required this.auth});

  AuthBase auth;

  Future<void> signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Sign in",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              ),
              MyRaisedButton(
                mColor: Colors.white,
                mPressed: () {
                  signInWithGoogle();
                },
                mChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset("images/google-logo.png"),
                    Text(
                      "Sign in with Google",
                      style: TextStyle(color: Colors.black87),
                    ),
                    Opacity(
                        opacity: 0.0,
                        child: Image.asset("images/google-logo.png")),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MyRaisedButton(
                mColor: Color(0XFF334092),
                mPressed: () {
                  signInWithFacebook();
                },
                mChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset("images/facebook-logo.png"),
                    Text(
                      "Sign in with Facebook",
                      style: TextStyle(color: Colors.white),
                    ),
                    Opacity(
                        opacity: 0.0,
                        child: Image.asset("images/facebook-logo.png")),
                  ],
                ),

              ),
              SizedBox(
                height: 10,
              ),
              MyRaisedButton(
                mColor: Colors.teal[700],
                mChild: Text(
                  "Sign in with Email",
                  style: TextStyle(color: Colors.white),
                ),
                mPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(fullscreenDialog: true,builder: (context)=>SignInEmailScreen(auth)));
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "or",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              MyRaisedButton(
                mColor: Colors.lime[200],
                mChild: Text(
                  "Go anomymous",
                  style: TextStyle(color: Colors.black),
                ),
                mPressed: () {
                  signInAnonymously();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
