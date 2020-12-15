import 'package:flutter/material.dart';
import 'package:cbo_employee/home/home.dart';

void main() => runApp(Main());

class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CBO Employee",
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: HomeLayout(),
    );
  }
}