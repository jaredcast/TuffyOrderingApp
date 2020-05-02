import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_app_362/database.dart';
import 'package:order_app_362/logins.dart';
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
  String _role = "customer";
  String _uid;

  DatabaseService myDatabase = new DatabaseService();
  QuerySnapshot userInfo;
  final firestoreInstance = Firestore.instance;

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
    //onPressed: signInCustomer,
    onPressed: signIn,
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

  // Widget buildRole() {
  //   return DropdownButton<String>(
  //            value: _role,
  //            items: <String>['customer', 'business'].map((String role) {
  //                 return new DropdownMenuItem<String>(
  //                   value: role,
  //                   child: new Text(role),
  //                 );
  //               }).toList(),
  //             onChanged: (String changedValue) {
  //               setState(() {
  //                  _role = changedValue;
  //               }
  //               );
  //             },
  //           );
  // }

  // Stream<QuerySnapshot> getUserSnapshots(BuildContext context) async* {
  //   final uid = await Provider.of(context),a
  // }

  // Future<String> getUserRole(String uid) async {
  //   DocumentSnapshot ds = await Firestore.instance.collection('users').document(uid).get();
  //   return ds.data['role'];
  // }

  // Future<void> signInCustomer() async{
    
  //   final formState = formKey.currentState;
  //   if (formState.validate()) {
  //     formState.save();
  //     try {
  //       FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));

  //       //Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerHome(user: user))); //go to customer homepage
  //     }
  //     catch(e) {
  //       print(e.message);
  //     }
  //   }
  // }

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




  // Future getPosts() async {
  //   var firestore = Firestore.instance;
  //   QuerySnapshot qn = await firestore.collection("users").getDocuments();
  //   return qn.documents;
  // }

  // getLatest(String email) {
  //   return Firestore.instance.collection('users')
  //   .where('email', isEqualTo: email).snapshots();
  // }
 



  // @override
  // void initState() {
  //   myDatabase.getData().then((results)
  //   {
  //     setState((){
  //       userInfo = results;
  //     });
  //   });
  // }

   Future<void> signInBusiness() async{
    final formState = formKey.currentState;
    if (formState.validate() &&_role == "business") {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
       //from here
        // _uid = user.uid;
        // Firestore.instance.collection('users').document(currentUid).collection('usersPosts');

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
                      //businessButton(),
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