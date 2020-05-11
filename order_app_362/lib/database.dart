import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference orderCollection = Firestore.instance.collection('orders');


  //Updates customer data
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

  Future createOrder(String entree, String drink, String side, String notes, String uid) async {
    return await orderCollection.document(uid).setData({
      'entree': entree,
      'drink': drink,
      'side': side,
      'notes': notes,
      'uid': uid
    });
  }

}