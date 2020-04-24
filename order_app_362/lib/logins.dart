import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Provide pages for customers and business owners

class CustomerHome extends StatefulWidget {
  const CustomerHome({
    Key key, 
    @required this.user
    }) : super(key: key);
  final FirebaseUser user;

  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome ${widget.user.email}'),
      centerTitle: true),
    );
  }
}
class BusinessHome extends StatefulWidget {
  const BusinessHome({
    Key key, 
    @required this.user
    }) : super(key: key);
  final FirebaseUser user;

  @override
  _BusinessHomeState createState() => _BusinessHomeState();
}

class _BusinessHomeState extends State<BusinessHome> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Business Owner ${widget.user.email}"),
      centerTitle: true),
    );
  }
}

//class _CustomerHomeState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Welcome Customer"),
//       centerTitle: true),
//     );
//   }
// }

// class LoginAsBusiness extends StatelessWidget {
//  @override
//   Widget build(BuildContext context) {
//      return Scaffold(appBar:
//      AppBar(title: Text("Welcome Business Owner"),
//      centerTitle: true),
//      );
//    }
//  }

