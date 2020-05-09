import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'order.dart';
import 'view_order.dart';


class Home extends StatelessWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;


  @override
  Widget build(BuildContext context) {
  String uID = user.uid;

  void navToOrder() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Order()));
  }

  void navToViewOrder() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewOrder()));
  }

  //  void navToViewOrder() {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewOrder()));
  // }

  Widget orderButton() {
    return RaisedButton(child: Text("Place an order"),
    color: Colors.blue,
    onPressed: navToOrder,
    );
  }

   Widget viewOrderButton() {
    return RaisedButton(child: Text("View orders"),
    color: Colors.blue,
    onPressed: navToViewOrder,
    );
  }

  // Widget getOrderButton() {
  //   return RaisedButton(child: Text("View orders"),
  //   color: Colors.blue,
  //   onPressed: navToViewOrder,
  //   );
  // }
  
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document(uID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        if (userDocument["role"] == "customer")
        {
          return Scaffold( //Go to home screen for customers
            appBar: AppBar(title: Text('Welcome ${user.email}'),
            centerTitle: true),
            body: Container(alignment: Alignment.center,
            child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,        
                    children: <Widget>[
                      orderButton() //Place an order
                    ]
                )
            ),
          )
          );   
        }
        else {
          return Scaffold( //Go to home screen for business users
            appBar: AppBar(title: Text('Business ${user.email}'),
            centerTitle: true),
            body: Container(alignment: Alignment.center,
            child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,        
                    children: <Widget>[
                      viewOrderButton()
                    ]
                )
            ),
          )
          );   
        }
      }
    );
    }
  }


// class Home extends StatelessWidget {
//   const Home({Key key, this.user}) : super(key: key);
//   final FirebaseUser user;

//   @override
//   Widget build(BuildContext context) {
//   String uID = user.uid;
//     return new StreamBuilder(
//       stream: Firestore.instance.collection('users').document(uID).snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return new Text("Loading");
//         }
//         var userDocument = snapshot.data;
//         return new Text(userDocument["role"]);
//       }
//   );
// }
// }

//before testing
// class Home extends StatelessWidget {
//   const Home({Key key, this.user}) : super(key: key);
//   final FirebaseUser user;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home ${user.email}'),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: Firestore.instance
//             .collection('users')
//             .document(user.uid)
//             .snapshots(),
//         builder:
//             (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (snapshot.hasData) {
//             return checkRole(snapshot.data);
//           }
//           return LinearProgressIndicator();
//         },
//       ),
//     );
//   }
  

//   Center checkRole(DocumentSnapshot snapshot) {
//     if (snapshot.data == null) {
//       return Center(
//         child: Text('no data set in the userId document in firestore'),
//       );
//     }
//     if (snapshot.data['role'] == 'business') {
//       return adminPage(snapshot);
//     } else {
//       return userPage(snapshot);
//     }
//   }

//   Center adminPage(DocumentSnapshot snapshot) {
//     return Center(
//         child: Text('${snapshot.data['role']} ${snapshot.data['email']}'));
//   }

//   Center userPage(DocumentSnapshot snapshot) {
//     return Center(child: Text(snapshot.data['email']));
//   }
// }
