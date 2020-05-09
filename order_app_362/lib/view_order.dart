import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:order_app_362/models/order_model.dart';
import 'order.dart';


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

String _uID = '';

Future getOrders() async {
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection("orders").getDocuments();
    return qs.documents;
}

Future getSingleOrder() async {
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection("orders").getDocuments();
    return Firestore.instance.collection('users').document(_uID).snapshots();
}

class ViewOrder extends StatefulWidget {
  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(title: Text("Viewing orders")),
      body: new Container(
      child: FutureBuilder(
        future: getOrders(),
        builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting)
        {
          return Center(child: Text("Loading..."),);
        }
        else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, index){
              return Card(child: ListTile(
                title: Text(snapshot.data[index].data["email"],
                style: new TextStyle(
                    fontSize: 30,
                    color: Colors.black
                  ),
                ),

                subtitle: Text(   
                "\nEntree: " + snapshot.data[index].data["entree"] +
                "\nDrink: " + snapshot.data[index].data["drink"] +
                "\nSide: " + snapshot.data[index].data["side"] +
                "\nNotes: " + snapshot.data[index].data["notes"] +
                "\nStatus: " + snapshot.data[index].data["status"],

                style: new TextStyle(
                    fontSize: 15,
                    color: Colors.black
                  ),
                ),
                onTap: () {
                  _uID = snapshot.data[index].data["uid"];
                  print(_uID);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSingleOrder()));
                }
                )
              );
            }
          );
        }
      })
    )
    );
  }
}



Widget buildOptions()
{
  String _status;
  DropdownButton<String>(
             value: _status,
             items: <String>['New', 'In progress', 'Ready for pickup', 'Out for delivery', 'Cancelled'].map((String status) {
                  return new DropdownMenuItem<String>(
                    value: status,
                    child: new Text(status),
                  );
                }).toList(),
              onChanged: (String changedValue) {
                   _status = changedValue;
              },
            );
}

class ViewSingleOrder extends StatefulWidget {
  @override
  ViewSingleOrderState createState() => ViewSingleOrderState();
}

class ViewSingleOrderState extends State<ViewSingleOrder> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(title: Text("Order")),
      body: new Container(
        margin: EdgeInsets.all(24),
        child: StreamBuilder(
          stream: Firestore.instance.collection('orders').document(_uID).snapshots(),
          builder: (context, snapshot){

          if (snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(child: Text("Loading..."),);
          }
          
          else {
            var userDocument = snapshot.data;
            return new Text("Entree: " + userDocument["entree"]
            + "\nDrink: " + userDocument["drink"] 
            + "\nSide: " + userDocument["side"] 
            + "\nNotes: " + userDocument["notes"] 
            + "\nEmail: " + userDocument["email"]
            + "\nStatus: " + userDocument["status"]
            + "\nUser ID: " + userDocument["uid"],          
            style:TextStyle(fontSize: 20));  

          }       
          }     
      ),
    )
  );
  }
}

    // return Scaffold(
    //   body: StreamBuilder(
    //   stream: Firestore.instance.collection('orders').snapshots(),
    //   builder: (context, snapshot){
    //     if(!snapshot.hasData){
    //       const Text('Loading');
    //     }
    //     else{
    //       return ListView.builder(
    //         itemCount: snapshot.data.documents.length,
    //         itemBuilder:(context, index){
    //           DocumentSnapshot myorder = snapshot.data.documents[index];
    //           return Stack(children: <Widget>[
    //             SizedBox(height:10.0),
    //             Text( '${myorder['entree']}'),
    //             SizedBox(height:10.0),
    //             Text( '${myorder['drink']}'),
    //             SizedBox(height:10.0),
    //             Text( '${myorder['side']}'),
    //             SizedBox(height:10.0),
    //             Text( '${myorder['entree']}'),
    //           ],);
    //         });
    //     }
    //   }
    // ,)
    // );