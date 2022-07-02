// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:phonedirectory/database_helper.dart';
import 'package:phonedirectory/main.dart';
import 'package:phonedirectory/models/todo.dart';

// final String phoneNumber;
// final String username;
class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String phoneNumber = "Unknown";
  String username = "Unknown";

  // This function is triggered when the "Save" button is pressed
  void _saveForm() async {
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      DatabaseHelper _dbHelper = DatabaseHelper();

      Todo _newTodo = Todo(phoneNumber: phoneNumber, username: username);

      await _dbHelper.insertTodo(_newTodo);

      print("Added");

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      iconSize: 26.0,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyHomePage(title: "title")));
                      },
                    ),
                    const Text(
                      'Add Data To The List',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 6.0),
                  child: TextFormField(
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Colors.black),
                    decoration: const InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.person,
                          size: 24.0,
                          color: Colors.black87,
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.blueAccent),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black12, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)))),
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 6.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value != null && value.trim().length < 10) {
                        return 'Invalid Phone Number.';
                      }

                      return null;
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Colors.black),
                    decoration: const InputDecoration(
                        labelText: "PhoneNumber",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.phone_android,
                          size: 24.0,
                          color: Colors.black87,
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.blueAccent),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black12, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)))),
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add Data"),
        isExtended: true,
        onPressed: _saveForm,
      ),
    );
  }
}
