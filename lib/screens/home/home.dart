import 'package:firebase_project/components/loading.dart';
import 'package:firebase_project/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  bool signoutLoading = false;

  @override
  Widget build(BuildContext context) {
    return (signoutLoading)?Loading():Scaffold(
       backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("FireBase Flutter"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () async{
              setState(()=>signoutLoading=true);
              dynamic result = await _auth.signOut();
              if(!result)print("Signed Out successfully");
              else print("error in Signing Out");
              setState(()=>signoutLoading=false);
            },
          ),
        ],
      ),
    );
  }
}
