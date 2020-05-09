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
                      orderButton(),//Place an order
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
