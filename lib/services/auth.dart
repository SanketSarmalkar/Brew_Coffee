import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/models/user.dart';
import 'package:firebase_project/services/database.dart';
import 'package:flutter/cupertino.dart';

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
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }


  // register with email & pass
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      // print(email);
      // print(password);
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


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