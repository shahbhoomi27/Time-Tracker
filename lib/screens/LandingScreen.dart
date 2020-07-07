import 'package:flutter/material.dart';
import 'package:time_tracker_app/screens/HomeScreen.dart';
import 'package:time_tracker_app/screens/SignInOptionScreen.dart';
import 'package:time_tracker_app/services/auth.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({@required this.auth});

  final AuthBase auth;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged, builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            User user = snapshot.data;
            if(user == null){
              return SignInOption(auth: auth);
            }
            return HomeScreen(auth: auth);
          }else{
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
    });

  }
}
