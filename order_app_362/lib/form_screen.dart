import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_app_362/logins.dart';
import 'package:order_app_362/sign_up.dart';

class FormScreen extends StatefulWidget {
  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {

  String _email;
  String _password;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }
        return null;
      },
      onSaved: (String value) //takes in a value
      {
        _email = value;
      },
    );
  }
  
  Widget customerButton() {
    return RaisedButton(child: Text("Login as Customer"),
    color: Colors.blue,
    onPressed: signInCustomer,
    );
  }
  Widget businessButton() {
    return RaisedButton(child: Text("Login as Business"),
    color: Colors.red,
    onPressed: signInBusiness,
    );
  }

  Widget signUpButton() {
    return RaisedButton(
      onPressed: navigateToSignUp,
      child: Text("Sign up"));
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
        else if (value.length < 4) {
          return 'Password is too short';
        }
        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Future<void> signInCustomer() async{
    final formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerHome(user: user))); //go to customer homepage
      }
      catch(e) {
        print(e.message);
      }
    }
  }

   Future<void> signInBusiness() async{
    final formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessHome(user: user))); //go to business homepage
      }
      catch(e) {
        print(e.message);
      }
    }
  }

  void navigateToSignUp() {
     Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  Widget buildImage()
  {
    return Image.asset('images/tuffy.png',
        height: 90,
        width: 90,
        fit: BoxFit.fitWidth);
  }

  //builds dropdown bar
  // String dropdownValue = 'Customer';
  // Widget buildDropdown(BuildContext context) {
  //   return DropdownButton<String>(
  //       value: dropdownValue,
  //       icon: Icon(Icons.arrow_downward),
  //       iconSize: 24,
  //       elevation: 16,
  //       style: TextStyle(
  //         color: Colors.black,
  //       ),
  //       underline: Container(
  //         height: 2,
  //         color: Colors.green,
  //       ),
      
  //       onChanged: (String newValue) {
  //         setState(() {
  //           dropdownValue = newValue;
  //         });
  //       },
  //       items: <String>['Customer', 'Business']
  //         .map<DropdownMenuItem<String>>((String value) {
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: Text(value),
  //           );
  //       })
  //       .toList()
  //   );
  // }

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
                      buildEmail(),
                      buildPassword(),
                      SizedBox(height: 20),
                      customerButton(),
                      businessButton(),
                      // buildDropdown(context),
                      SizedBox(height: 10),
                      signUpButton(),
                      // RaisedButton(
                      //   child: Text('Submit', style: TextStyle(
                      //     color: Colors.red,
                      //     fontSize:16,),
                      //   ),
                      //   onPressed: () {
                      //     if (!formKey.currentState.validate()) {
                      //       return;
                      //     }

                      //     formKey.currentState.save(); //state is correct, save. print in console
                      //     // print(email);
                      //     // print(password);

                      //   },
                      // )
                    ]
                )
            ),

        )
    );
  }
}



//Old widget buttons
// Widget customerButton() {
  //   return FlatButton(child: Text("Login as Customer"),
  //   color: Colors.blue,
  //   onPressed: () {
  //     if (!formKey.currentState.validate()) {
  //       return;
  //     }
  //     Navigator.pushNamed(context, '/LoginAsCustomer');
  //   },
  //   );
  // }
  // Widget businessButton() {
  //   return FlatButton(child: Text("Login as Business"),
  //   color: Colors.red,
  //   onPressed: () {
  //     if (!formKey.currentState.validate()) {
  //       return;
  //     }
  //     Navigator.pushNamed(context, '/LoginAsBusiness');
  //   },
  //   );
  // }