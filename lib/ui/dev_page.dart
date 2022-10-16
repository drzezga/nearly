import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/bloc/settings_cubit.dart';
import 'package:settings_ui/settings_ui.dart';

class DevPage extends StatefulWidget {
  const DevPage({Key? key}) : super(key: key);

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  var warningsState = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text("Flutter Flat Button"),
          ),
          body: Container(
              width:double.infinity ,
              padding: EdgeInsets.all(20),
              alignment: Alignment.topCenter,
              child:TextButton(
                child:Text("Button"),
                onPressed: () {
                },
              )
          ),
        )
    );
  }
}
