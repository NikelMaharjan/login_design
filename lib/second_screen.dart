import 'package:flutter/material.dart';
import 'package:login_page/helper/constants.dart';

class SecondScreen extends StatelessWidget {
  final String email;
  SecondScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Second Screen"),
      ),

      body: Center(
        child: Text("Your Email $email", style: Theme.of(context).textTheme.headline6,),

      ),
    );
  }
}
