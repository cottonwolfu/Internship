// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

// import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluent_ui/fluent_ui.dart';
import 'package:firedart/firedart.dart';

const apiKey = 'AIzaSyCV4gnAJGQNerRBG5mWLpzw_xnduOIeU1M';
const projectId = 'flutterfirebaseseries-82378';

void main() {
  Firestore.initialize(projectId);
  runApp(MaterialApp(title: "abc", home: FireStoreHome()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GlobalKey _formKey = GlobalKey<FormState>();

  final TextEditingController _pswController = TextEditingController();
  var a = "123";
  @override
  Widget build(BuildContext context) {
    const styles = TextStyle(
      color: Colors.yellow,
      fontFamily: 'yahei',
    );
    _pswController.addListener(
      () {
        print(_pswController.text);
      },
    );
    return MaterialApp(
      title: "lalala",
      home: Scaffold(
          appBar: AppBar(
              title: const Text("MiaoMiaoMiao"),
              leading: Builder(builder: (context) {
                return TextButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Text("go"));
              })),

          //正文
          body: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              SizedBox(
                  height: 400,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "lib/Img/youyou.jpg",
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 300,
                            width: 100,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                children: <Widget>[
                                  Form(
                                    key: _formKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                      children: <Widget>[
                                        const Text(
                                            textAlign: TextAlign.left, "Tina"),
                                        TextFormField(
                                          autofocus: true,
                                          decoration: const InputDecoration(
                                              labelText: "MiaoMiaoMiao"),
                                          // validator: (val) {
                                          //   if (val.isEmpty) {}
                                          //   return val.length > 0
                                          //       ? null
                                          //       : "Please enter User Name";
                                          // },
                                        ),
                                        OutlinedButton(
                                            onPressed: () {
                                              if ((_formKey.currentState
                                                      as FormState)
                                                  .validate()) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FirstPage()));
                                              }
                                            },
                                            child: const Text("This is button"))
                                      ],
                                    ),
                                  ),
                                  const Text("User Name"),
                                  TextField(
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                        labelText: "UserName",
                                        hintText: "Please enter your email",
                                        prefixIcon: Icon(Icons.mail)),
                                    keyboardType: TextInputType.text,
                                    onChanged: (val) {
                                      print(val);
                                    },
                                  ),
                                  TextField(
                                    autofocus: true,
                                    decoration: const InputDecoration(),
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    controller: _pswController,
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  )),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     color: Colors.yellow,
              //     alignment: Alignment.topCenter,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         Text("part 1part 1part 1"),
              //         Text("part 2")
              //       ],
              //     ),
              //   ),
              // ),
              // Expanded(
              //     flex: 2,
              //     child: Container(
              //       color: Colors.red,
              //     ))
            ],
          )),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("First page")),
      body: Column(children: <Widget>[
        OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondPage()));
            },
            child: const Text("go to Second Page"))
      ]),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second page")),
      body: Column(children: <Widget>[
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("go to First Page"))
      ]),
    );
  }
}

class FireStoreHome extends StatefulWidget {
  const FireStoreHome({Key? key}) : super(key: key);

  @override
  State<FireStoreHome> createState() => _FireStoreHomeState();
}

class _FireStoreHomeState extends State<FireStoreHome> {
  CollectionReference testCollection = Firestore.instance.collection('User');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(
        child: Column(children: [
          OutlinedButton(
              onPressed: () {
                testCollection
                    .add({'full_name': 'siming'})
                    .then((value) => print("$value Added"))
                    .catchError((Error) => print("miaomiaomiao"));
              },
              child: Text("输入")),
          OutlinedButton(
              onPressed: () async {
                final users = await testCollection.get();
                print(users);
              },
              child: const Text('List User'))
        ]),
      ),
    );
  }
}
