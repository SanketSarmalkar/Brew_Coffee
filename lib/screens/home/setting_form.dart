import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/components/loading.dart';
import 'package:firebase_project/models/user.dart';
import 'package:firebase_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  SettingForm({Key? key}) : super(key: key);

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName = "";
  String _currentSugars = "";
  int _currentStrength = 0;
  var error = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUid?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    validator: (val) =>
                        val!.length == 0 ? 'name cannot be empty' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // dropdown
                  DropdownButtonFormField(
                    // value: (_currentSugars == "")
                    //     ? userData.sugars
                    //     : _currentSugars,
                    hint: Text(userData!.sugars),
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars=val.toString()),
                  ),
                  // slider
                  SizedBox(
                    height: 20.0,
                  ),
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor: Colors.brown[
                        (_currentStrength == 0) ? userData!.strength : _currentStrength],
                    value: ((_currentStrength==0)?userData!.strength:_currentStrength).toDouble(),
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),

                  MaterialButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        if(_currentSugars=="0"){
                          setState(()=>_currentSugars = userData!.sugars);
                        }
                        if(_currentName==""){
                          setState(()=>_currentName = userData!.name);
                        }
                        if(_currentStrength==0){
                          setState(()=>_currentStrength = userData!.strength);
                        }
                          print(_currentName);
                          print(_currentSugars);
                          print(_currentStrength);
                          await DatabaseService(uid: user!.uid).updateUserData(_currentSugars, _currentName, _currentStrength);
                      }
                    },
                    color: Colors.brown[500],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text(error),
                ],
              ),
            );
          }else{
            return Loading();
          }
        });
  }
}
