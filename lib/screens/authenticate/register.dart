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

  // text field state
  String email = '';
  String password = '';
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  if(_formKey.currentState!.validate()) {
                     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                     if(result==null){
                       setState(()=>error = "pls. enter a valid email address");
                     }
                  }
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
