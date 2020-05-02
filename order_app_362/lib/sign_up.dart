import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_app_362/database.dart';
import 'home.dart';
import 'logins.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}



class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password, _role = 'customer';
  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[

          TextFormField( //Email
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
            ),

            TextFormField(
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
            ),
           
           new DropdownButton<String>(
             value: _role,
             items: <String>['customer', 'business'].map((String role) {
                  return new DropdownMenuItem<String>(
                    value: role,
                    child: new Text(role),
                  );
                }).toList(),
              onChanged: (String changedValue) {
                setState(() {
                   _role = changedValue;
                }
                );
              },
            ),
            

            RaisedButton(
              onPressed: signUp,
              child: Text('Sign up'),
              ),
            ],
          )
        ,)
    );
  }

  void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        
        await DatabaseService(uid: user.uid).updateUserData(_email, _role, user.uid);
        user.sendEmailVerification(); //Display for user that we sent email - to be done
        Navigator.of(context).pop();
        if (_role == "customer") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
        }
        else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BusinessHome(user: user)));
        }
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomerHome(user: user)));
      }catch(e){
        print(e.message);
      }
    }
  }
}

// class DatabaseService {
//   final String uid;
//   DatabaseService({this.uid});

//   final CollectionReference userCollection = Firestore.instance.collection('users');

//   Future<void> updateUserData(String email, String password, String role) async {
//     return await userCollection.document(uid).setData({
//       'email': email,
//       'password': password,
//       'role': role,
//     });
// }



