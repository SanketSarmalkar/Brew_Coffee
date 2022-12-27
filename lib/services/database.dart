import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/models/brew.dart';
import 'package:firebase_project/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  DatabaseService.withoutUID() : uid = "";

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  //stream
  Stream<List<Brew>> get data {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //add data
  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugar': sugar,
      'name': name,
      'strength': strength,
    }).onError((error, stackTrace) => null);
  }

  //get data
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((j) {
      return Brew(
          name: j.get('name') ?? '',
          strength: j.get('strength') ?? 0,
          sugars: j.get('sugar') ?? '0');
    }).toList();
  }

  // userdata snapshot
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: snapshot.data['uid'],
  //       name: snapshot.get('name'),
  //       sugars: snapshot.get("sugar"),
  //       strength: snapshot.get('strength'));
  // }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map((j) {
      return UserData(
          uid: uid,
          name: j.get('name'),
          strength: j.get('strength'),
          sugars: j.get('sugar'));
    });
  }
}
