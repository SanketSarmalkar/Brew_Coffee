import 'package:flutter/material.dart';


class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String _currentName = "";
  String _currentSugars = "";
  int _currentStrength = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          Text(
              'Update your brew settings.',
              style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            validator: (val)=>val!.length==0?'name cannot be empty':null,
            onChanged: (val)=>setState(()=>_currentName=val),
          ),
          SizedBox(height: 20.0,),
          // dropdown
          DropdownButtonFormField(
              items: sugars.map((sugar){
                return DropdownMenuItem(
                  value: sugar,
                  child: Text('${sugar} sugars'),
                );
              }).toList(),
              onChanged: (val)=>setState(()=>_currentSugars=val!),
          ),
          // slider
          SizedBox(height: 20.0,),
          Slider(
              min: 100,
              max: 900,
              divisions: 8,
              activeColor: Colors.brown[(_currentStrength==0)?100:_currentStrength],
              value: ((_currentStrength!=0)?_currentStrength:100).toDouble(),
              onChanged: (val)=>setState(()=>_currentStrength=val.round()),
          ),

          MaterialButton(
            onPressed: (){
              if(_formkey.currentState!.validate()){
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
              }
            },
            color: Colors.brown[500],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
