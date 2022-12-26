import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/components/loading.dart';
import 'package:firebase_project/screens/home/brew_list.dart';
import 'package:firebase_project/screens/home/setting_form.dart';
import 'package:firebase_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/services/database.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  void _showSettingPanel(){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: SettingForm(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      initialData:[],
      value: DatabaseService.withoutUID().data,
      child: Scaffold(
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
            IconButton(
                onPressed: (){
                   _showSettingPanel();
                },
                icon: Icon(Icons.settings),

            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
