import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/bloc/settings_cubit.dart';

import 'ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => NotificationPreferencesCubit(), lazy: false,)
    ], child: MaterialApp(
      title: "Nearly",

      theme: ThemeData(
        useMaterial3: true,
        // fontFamily: ,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // appBarTheme: AppBarTheme(
        //   backgroundColor: Colors.indigo.shade100
        // ),
        // canvasColor: Colors.indigo.shade50,
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(title: 'Nearly'),
    ));
    // return
  }
}
