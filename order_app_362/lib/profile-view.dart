import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile{
  String uid;
  String email;
  String role;

  Profile.fromMap(Map<String, dynamic> data){
    uid = data['uid'];
    email = data['email'];
    role = data['role'];  
  }
}

// class ProfileView extends StatefulWidget {

//   @override
//   _ProfileViewState createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: Text("testing")),
//     body: StreamBuilder(
//       stream: Firestore.instance.collection('users').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text('loading.....');
//         return ListView.builder(
//           itemBuilder: (context, index) =>
//           _buildListItem(context, _list[index])),
//       },

//     )
    
    
//     );
//   }
// }