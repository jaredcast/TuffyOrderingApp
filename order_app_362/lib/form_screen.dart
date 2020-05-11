import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_app_362/database.dart';
import 'package:order_app_362/sign_up.dart';
import 'package:order_app_362/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormScreen extends StatefulWidget {
  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {

  String _email;
  String _password;

  DatabaseService myDatabase = new DatabaseService();
  QuerySnapshot userInfo;
  final firestoreInstance = Firestore.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
        if (value.isEmpty) {
          return 'Email is Required';
        }    
        else if (emailValid == false)
        {
          return 'Not in email format.';
        }
        return null;
      },
      onSaved: (String value) //takes in a value
      {
        _email = value;
      },
    );
  }
  
  Widget signInButton() {
    return RaisedButton(child: Text("Sign in"),
    color: Colors.blue,
    //onPressed: signInCustomer,
    onPressed: signIn,
    );
  }


  Widget signUpButton() {
    return RaisedButton(
      color: Colors.green,
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

  void signIn() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      try{
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
      }catch(e){
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

    void getStuff(x) async{
    FirebaseUser firebaseUser = x;
    firestoreInstance.collection("users").document(firebaseUser.uid).get().then((value){
      print(value.data);
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Tuffy Ordering Login"),
            centerTitle: true
        ),

        body:SingleChildScrollView(child:
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
                      signInButton(),
                      SizedBox(height: 10),
                      signUpButton(),               
                    ]
                )
            ),

        
        )
      )
    );
  }
}
