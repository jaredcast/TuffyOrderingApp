import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Order extends StatefulWidget {

  const Order({Key key, this.user}) : super(key: key);
  //const Order({Key key, this.user, @required this.uid}) : super(key: key);
  final FirebaseUser user;

  @override
  _OrderState createState() => _OrderState();
}
//Testing before push
class _OrderState extends State<Order> {
  String _entree = 'N/A';
  String _drink = 'N/A';
  String _side = 'N/A';
  String _notes;
  
  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
    appBar: new AppBar(title: Text("Placing an order")),
    body: SingleChildScrollView(child:
      Container( 
        alignment: Alignment.topLeft,
        margin: EdgeInsets.all(24),
        child: 
          Column( //Many widgets go in column.
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            Text("Entree:", style: TextStyle(fontSize: 30, decoration: TextDecoration.underline,)),
            buildEntree(),
            Text("Drink:", style: TextStyle(fontSize: 30, decoration: TextDecoration.underline,)),
            buildDrink(),
            Text("Side:", style: TextStyle(fontSize: 30, decoration: TextDecoration.underline,)),
            buildSide(),
            Text("Notes:", style: TextStyle(fontSize: 30, decoration: TextDecoration.underline,)),
            buildNotes(),
            placeOrder(),
            
            ],
          )
      ),
    )
    );   
  }

  Widget buildEntree()
  {
    return DropdownButton<String>(
             value: _entree,
             items: <String>['Burger', 'Pizza', 'Salad', 'Sandwich', 'N/A'].map((String entree) {
                  return new DropdownMenuItem<String>(
                    value: entree,
                    child: new Text(entree),
                  );
                }).toList(),
              onChanged: (String changedValue) {
                setState(() {
                   _entree = changedValue;
                }
                );
              },
            );
  }

  Widget buildDrink()
  {
    return DropdownButton<String>(
             value: _drink,
             items: <String>['Soda', 'Water', 'Lemonade', 'Coffee', 'Tea', 'N/A'].map((String drink) {
                  return new DropdownMenuItem<String>(
                    value: drink,
                    child: new Text(drink),
                  );
                }).toList(),
              onChanged: (String changedValue) {
                setState(() {
                   _drink = changedValue;
                }
                );
              },
            );
  }

  Widget buildSide()
  {
    return DropdownButton<String>(
             value: _side,
             items: <String>['Chips', 'Soup', 'Coleslaw', 'Fruit', 'Fries', 'Small salad', 'Mashed potatoes', 'Yogurt', 'N/A'].map((String side) {
                  return new DropdownMenuItem<String>(
                    value: side,
                    child: new Text(side),
                  );
                }).toList(),
              onChanged: (String changedValue) {
                setState(() {
                   _side = changedValue;
                }
                );
              },
            );
  }

  Widget buildNotes()
  {
    _notes = "N/A"; //Will pass this in if nothing is changed.
    return Container(
      width:200,
      child:TextFormField( 
        decoration: InputDecoration(labelText: 'Notes'),
        onChanged: (String value) //takes in a value
        {
          _notes = value;

        },
        )); 
  }

  Widget placeOrder() {
    return RaisedButton(child: Text("Submit Order"),
    color: Colors.green,
    onPressed:  sendOrder
    );
  }

  void sendOrder() async //Sends a new order.
  {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uID = user.uid;
    String email = user.email;
    String status = "New";
    Firestore.instance.collection("orders").document(uID).setData(
      {'entree': _entree,
      'drink': _drink,
      'side': _side,
      'notes': _notes,
      'uid': uID,
      'email': email,
      'status': status}
    );
  }
}

