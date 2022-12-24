import 'package:firebase_project/models/user.dart';
import 'package:firebase_project/screens/authenticate/authenticate.dart';
import 'package:firebase_project/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserUid?>(context);
    //print(user);
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
