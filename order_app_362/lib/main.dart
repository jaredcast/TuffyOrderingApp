import 'package:order_app_362/form_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuffy Ordering',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: FormScreen(),
       routes: <String, WidgetBuilder> {
      //   '/LoginAsCustomer' : (context) => LoginAsCustomer(),
      //     '/LoginAsBusiness' : (context) => LoginAsBusiness()
       }
    );
  }
}










// import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(
//   home: Scaffold( //wrapper
//     appBar: AppBar(
//       title: Text('Tuffy Ordering!'),
//       centerTitle: true,
//       backgroundColor: Colors.red[400],
//     ),
//     body: Center(
//         child: Text(
//             'Tuffy Ordering: Welcome.',
//             style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2,
//             ),
//         ),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {},
//       child: Text('Login'),
//       backgroundColor: Colors.red[400]
//     ),
//   ),
// ));


/* from tutorial
class Home extends StatelessWidget { //cannot change over time
  @override
  Widget build(BuildContext context) { //redefine build method
    return Scaffold( //wrapper
      appBar: AppBar(
        title: Text('Tuffy Ordering!'),
        centerTitle: true,
        backgroundColor: Colors.red[400],
      ),
      body: Center(
        child: Text(
          'Tuffy Ordering: Welcome.',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Text('Login'),
          backgroundColor: Colors.red[400]
      ),
    );
  }
}

 */