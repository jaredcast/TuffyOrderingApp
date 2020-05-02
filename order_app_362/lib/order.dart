import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_app_362/database.dart';
import 'logins.dart';



class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {

  String _entree = 'N/A';
  String _drink = 'N/A';
  String _side = 'N/A';
  String _notes;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    appBar: new AppBar(title: Text("Placing an order")),
    body: 
      Container( 
        alignment: Alignment.topLeft,
        margin: EdgeInsets.all(24),
        child: 
          Column( 
            children: <Widget>[
            Text("Entree:", style: TextStyle(fontSize: 30, decoration: TextDecoration.underline,)),
            buildEntree(),
            // buildSide(),
            Text("Drink:", style: TextStyle(fontSize: 30, decoration: TextDecoration.underline,)),
            buildDrink()
            ],
          )
      ),
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
             items: <String>['Chips', 'Soup', 'Coleslaw', 'Fruit', 'Fries', 'Small salad', 'Mashed potatoes', 'Yogurt'].map((String side) {
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
    return TextFormField( //Email
            decoration: InputDecoration(labelText: 'Notes'),
              onSaved: (String value) //takes in a value
              {
                _notes = value;
              },
            );
  }

  

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

