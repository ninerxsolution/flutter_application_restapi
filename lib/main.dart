import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_restapi_2/screens/todo_list.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TodoListPage(),
    );
  }
}
