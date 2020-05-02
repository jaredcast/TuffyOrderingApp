import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String email, String role, String uid) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'role': role,
      'uid': uid
    });
  }

    getData() async{
    return await Firestore.instance.collection('users').getDocuments();
  }

}