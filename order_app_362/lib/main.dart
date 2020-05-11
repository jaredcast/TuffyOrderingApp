import 'package:order_app_362/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:order_app_362/profile_notifier.dart';
import 'package:provider/provider.dart';
import 'package:order_app_362/auth_notifier.dart';


// void main() => runApp(MyApp());

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (context) => AuthNotifier(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProfileNotifier(),
    ),
  ],
  child: MyApp(),
    )
  );

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
       }
    );
  }
}
