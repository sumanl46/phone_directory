// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:phonedirectory/screens/add_todo.dart';
import 'package:phonedirectory/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff0f0f0),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.1)),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                height: double.infinity,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: TextField(
                      style: TextStyle(fontSize: 15.0),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black54,
                            size: 26.0,
                          ),
                          hintText: 'Search in lists'),
                      onSubmitted: (value) {
                        print(value);
                      },
                    )),
                    SizedBox(
                      width: 40,
                      height: double.infinity,
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.black54,
                          onPressed: () {
                            print("Pressed");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                initialData: [],
                future: _dbHelper.getTodos(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ScrollConfiguration(
                        behavior: MaterialScrollBehavior(),
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(snapshot.data[index].phoneNumber),
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.redAccent,
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) {
                                  _dbHelper
                                      .deleteTodo(snapshot.data[index].id)
                                      .then((value) => Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text('Item Removed.'),
                                            duration: Duration(
                                                seconds: 2, milliseconds: 100),
                                            dismissDirection:
                                                DismissDirection.down,
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black12))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            snapshot.data[index].username,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            snapshot.data[index].phoneNumber,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TodoPage()))
              .then((value) {
            setState(() {});
          });
        },
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.add,
          size: 35.0,
        ),
        mini: false,
      ),
    );
  }
}
