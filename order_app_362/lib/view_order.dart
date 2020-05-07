import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// class ViewOrder extends StatelessWidget {
//   const ViewOrder({Key key, this.user}) : super(key: key);
//   final FirebaseUser user;

//   @override
//   Widget build(BuildContext context) {
//     String uID = user.uid; //business uid
//     return StreamBuilder(
//       stream: Firestore.instance.collection('orders').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) return new Text("There is no expense");
//         return new ListView(children: getOrders(snapshot));
//     });
//   }

  // getOrders(AsyncSnapshot<QuerySnapshot> snapshot) {
  //   return snapshot.data.documents.map((doc) => new ListTile(title: new Text(doc["entree"]),
  //     subtitle: new Text(doc["drink"]),
  //     isThreeLine: ,
  //   ));
  // }
//}