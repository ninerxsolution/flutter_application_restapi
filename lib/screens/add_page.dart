import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_restapi_2/screens/add_page.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Map? todo;

  const AddTodoPage({
    super.key,
    this.todo,
  });
  // const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final name = todo['name'];
      final gender = todo['gender'];
      final major = todo['major'];
      final year = todo['year'];
      nameController.text = name;
      genderController.text = gender;
      majorController.text = major;
      yearController.text = year;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Todo' : 'Add Todo',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          TextField(
            controller: genderController,
            decoration: InputDecoration(hintText: 'Gender'),
          ),
          TextField(
            controller: majorController,
            decoration: InputDecoration(hintText: 'Major'),
          ),
          TextField(
            controller: yearController,
            decoration: InputDecoration(hintText: 'Year'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                isEdit ? 'Update' : 'Submit',
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = todo['id'];
    // final isCompleted = todo
    final name = nameController.text;
    final gender = genderController.text;
    final major = majorController.text;
    final year = yearController.text;
    final body = {
      "name": name,
      "gender": gender,
      "major": major,
      "year": year,
    };
    final uri = Uri.parse('http://localhost:8000/students/$id');
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      showSuccessMessage('Update success');
    } else if (response.statusCode != 200) {
      showErrorMessage('Update error');
    }
  }

  Future<void> submitData() async {
    final name = nameController.text;
    final gender = genderController.text;
    final major = majorController.text;
    final year = yearController.text;
    final body = {
      "name": name,
      "gender": gender,
      "major": major,
      "year": year,
    };
    final uri = Uri.parse('http://localhost:8000/students');
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      nameController.text = '';
      genderController.text = '';
      majorController.text = '';
      yearController.text = '';
      showSuccessMessage('Creation success');
    } else if (response.statusCode != 200) {
      showErrorMessage('Creation error');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
