import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_app/services/auth.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({@required this.auth});

  AuthBase auth;
  @override
  Widget build(BuildContext context) {


    void _signOut() async{
      await auth.signOut();

    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          FlatButton(onPressed: (){_signOut();}, child: Text("Logout",style: TextStyle(fontSize: 18,color: Colors.white),),),
        ],
      ),
    );
  }


}
