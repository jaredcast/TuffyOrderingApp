import 'package:flutter/material.dart';
class FormScreen extends StatefulWidget {
  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {

  String username;
  String password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildUsername() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Username'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Username is Required';
        }
        return null;
      },
      onSaved: (String value) //takes in a value
      {
        username = value;
      },
    );
  }

  String dropdownValue = 'Customer';
  Widget buildDropdown(BuildContext context) {
    return DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: Colors.black,
        ),
        underline: Container(
          height: 2,
          color: Colors.green,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Customer', 'Business']
          .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
        })
        .toList()
    );
  }

  Widget buildPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      keyboardType: TextInputType.visiblePassword, //gets you different keyboard types to use
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }
        return null;
      },
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget buildImage()
  {
    return Image.asset('images/tuffy.png',
        height: 90,
        width: 90,
        fit: BoxFit.fitWidth);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Tuffy Ordering Login"),
            centerTitle: true
        ),

        body:

        Container(
            margin: EdgeInsets.all(24),
            child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      buildImage(),
                      buildUsername(),
                      buildPassword(),
                      buildDropdown(context),
                      SizedBox(height: 10),
                      RaisedButton(
                        child: Text('Submit', style: TextStyle(
                          color: Colors.red,
                          fontSize:16,),
                        ),
                        onPressed: () {
                          if (!formKey.currentState.validate()) {
                            return;
                          }

                          formKey.currentState.save(); //state is correct, save. print in console
                          print(username);
                          print(password);

                        },
                      )
                    ]
                )
            ),

        )
    );
  }
}
