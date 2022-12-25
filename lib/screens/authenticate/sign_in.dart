import 'package:firebase_project/components/loading.dart';
import 'package:firebase_project/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  // text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Sign In'),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                widget.toggleView();
              },
              child: Row(
                children: [Icon(Icons.app_registration), Text("register")],
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      )),
                  validator: (val) => (val!.isEmpty)
                      ? 'email cannot be empty'
                      : (error.isEmpty)
                          ? null
                          : error,
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
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      )),
                  obscureText: true,
                  validator: (val) => (val!.length < 8)
                      ? 'password should have more than 8 characters'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: () async {
                    setState(() => loading = true);
                    if (_formkey.currentState!.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() => error = 'invalid Email Id or Password');
                      }
                    }
                    setState(() => loading = false);
                  },
                  color: Colors.brown[900],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
