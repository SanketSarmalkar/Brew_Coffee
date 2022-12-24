import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebaseUser
  UserUid? _userFromFirebaseUser(User? user){
    return (user!=null)? UserUid(uid:user.uid):null;
  }

  //auth change user stream
  Stream<UserUid?> get user{
    return _auth.authStateChanges()
        //.map((User? user)=>_userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
       print(e.toString());
       return null;
    }
  }

  // sign in with email & pass


  // register with email & pass

  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}