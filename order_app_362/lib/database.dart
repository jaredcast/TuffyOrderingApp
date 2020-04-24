// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseService {

//   final String uid;
//   DatabaseService({ this.uid });

//   // collection reference
//   final CollectionReference userCollection = Firestore.instance.collection('users');

//   Future<void> updateUserData(String email, String role) async {
//     return await userCollection.document(uid).setData({
//       'email': email,
//       'role': role,
//     });
//   }

// }