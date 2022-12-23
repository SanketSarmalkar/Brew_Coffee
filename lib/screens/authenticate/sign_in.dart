import 'package:firebase_project/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth  = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child:MaterialButton (
          color: Colors.brown[500],
          child: Text('Sign in anon'),
          onPressed:() async{
            dynamic result = await _auth.signInAnon();
            if(result==null){
              print('error signing in');
            }else{
              print('signed in');
              print(result);
            }
          },
        )

      ),
    );
  }
}
