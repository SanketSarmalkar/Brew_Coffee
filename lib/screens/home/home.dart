import 'package:firebase_project/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("FireBase Flutter"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () async{
              dynamic result = await _auth.signOut();
              if(!result)print("Signed Out successfully");
              else print("error in Signing Out");
            },
          ),
        ],
      ),
    );
  }
}
