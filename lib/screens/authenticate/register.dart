import 'package:firebase_project/components/loading.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return (loading)?Loading():Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up'),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              widget.toggleView();
            },
            child:Row(
              children: [
                Icon(Icons.app_registration),
                Text("sign In")
              ],
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText:'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  )
                ),
                  validator: (val)=>val!.isEmpty? 'Enter an Email':(error=="")?null:error,
                  onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText:'Password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    )
                ),
                obscureText: true,
                  validator: (val)=>val!.length<8?'Password should have minimum lenght of 8':null,
                  onChanged: (val) {
                  setState(()=> password=val);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                onPressed: () async {
                  // print(email);
                  // print(password);
                  setState(()=>loading=true);
                  if(_formKey.currentState!.validate()) {
                     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                     if(result==null){
                       setState(()=>error = "Invalid email ID or Email already exist");
                     }
                  }
                  setState(()=>loading=false);
                },
                color: Colors.brown[900],
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.grey[200]),
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
