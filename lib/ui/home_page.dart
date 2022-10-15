import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/bloc/tag_bloc.dart';
import 'package:hackathon/ui/read_tag_card.dart';
import '../bloc/settings_cubit.dart';
import '../model/tag.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        // mainAxisAlignment: MainAxisAlignment.start,
        slivers: [
          SliverAppBar.large(
              title: Text(widget.title,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.w800)),
              titleSpacing: 0,
              actions: [
                IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //     builder: (context) => BlocProvider(create: (_) => NotificationPreferencesCubit(), child: const SettingsPage())),
                                  builder: (_) => const SettingsPage()))
                        })
              ]),
          SliverToBoxAdapter(child: BlocBuilder<TagBloc, List<Tag>>(
            builder: (context, state) {
              return Column(
                children: [
                  for (var tag in state)
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: ReadTagCard(tag, onTap: () {}))
                ],
              );
            },
          )),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          //     child: ReadTagCard(const Text("dwqhiududguiwq"), onTap: () {}),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          //     child: ReadTagCard(const Text("dwqhiududguiwq"), onTap: () {}),
          //   ),
          // ),
        ],
      ),
    );
  }
}
