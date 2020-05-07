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

class _OrderState extends State<Order> {
  String _entree = 'N/A';
  String _drink = 'N/A';
  String _side = 'N/A';
  String _notes;
  String _uid;
  
  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
    appBar: new AppBar(title: Text("Placing an order")),
    body: SingleChildScrollView(child:
      Container( 
        alignment: Alignment.topLeft,
        margin: EdgeInsets.all(24),
        child: 
          Column( 
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
            placeOrder()
            
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
    return Container(
      width:200,
      child:TextFormField( 
        decoration: InputDecoration(labelText: 'Notes'),
        validator: (String value) {
          if (value.isEmpty) {
            return 'None';
          }
          return null;
          },
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

  void sendOrder() async
  {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uID = user.uid;
    String email = user.email;
    Firestore.instance.collection("orders").document(uID).setData(
      {'entree': _entree,
      'drink': _drink,
      'side': _side,
      'notes': _notes,
      'uid': uID,
      'email': email}
    );
  }
  

  // void sendOrder() async {
  //   StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance.collection("orders").snapshots(),
  //     builder:(context,snapshot) {
  //       if (!snapshot.hasData){
  //         Text("Loading");
  //       }
  //       else{
  //         List<DropdownMenuItem> items
  //       }
  //     }
  //   )
  // }
  

  // Widget buildEntree() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Entree'),
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return '';
  //       }
  //       return null;
  //     },
  //     onSaved: (String value) //takes in a value
  //     {
  //       _entree = value;
  //     },
  //   );
  // }

  // Widget buildSide() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Side'),
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return '';
  //       }
  //       return null;
  //     },
  //     onSaved: (String value) //takes in a value
  //     {
  //       _side = value;
  //     },
  //   );
  // }

  // Widget buildDrink() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Drink'),
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return '';
  //       }
  //       return null;
  //     },
  //     onSaved: (String value) //takes in a value
  //     {
  //       _drink = value;
  //     },
  //   );
  // }
}

