import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String _uID = '';

Future getOrders() async {
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection("orders").getDocuments();
    return qs.documents;
}

Future getSingleOrder() async {
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


class ViewSingleOrder extends StatefulWidget {
  @override
  ViewSingleOrderState createState() => ViewSingleOrderState();
}

class ViewSingleOrderState extends State<ViewSingleOrder> {
  String _status = 'New';

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
          stream: Firestore.instance.collection('orders').document(_uID).snapshots(),
          builder: (context, snapshot){
          var userDocument = snapshot.data;
          
          return Scaffold(
            appBar: AppBar(title: Text('Getting order'),
            centerTitle: true),
            body: SingleChildScrollView(child: 
            Container(alignment: Alignment.center,
            margin: EdgeInsets.all(24),
            child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,        
                    children: <Widget>[
                      
                      Text("Entree: " + userDocument["entree"]
                      + "\nDrink: " + userDocument["drink"] 
                      + "\nSide: " + userDocument["side"] 
                      + "\nNotes: " + userDocument["notes"] 
                      + "\nEmail: " + userDocument["email"]
                      + "\nStatus: " + userDocument["status"]
                      + "\nUser ID: " + userDocument["uid"],          
                      style:TextStyle(fontSize: 20)),
                      buildStatus(), //build all widgets as children
                      

                      RaisedButton(child: Text("Submit status of order"),
                      color: Colors.blue,
                      onPressed: updateStatus
                      )
                    ]
                )
              ),
            )           
          )
        ); 
      }     
    );   
  }

  Widget buildStatus()
  { 
    return DropdownButton<String>(
      value: _status,
      items: <String>['New', 'In progress', 'Ready for pickup', 'Out for delivery',
      'Delivered', 'Complete', 'Cancelled'].map((String status) {
          return new DropdownMenuItem<String>(
            value: status,
            child: new Text(status),
          );
        }).toList(),
        onChanged: (String changedValue) {
        setState(() {
            _status = changedValue;
        }
        );
      },
    );
  }

  void updateStatus() {
    Firestore.instance.collection('orders').document(_uID).updateData({
      'status': _status
    });
  }
}
