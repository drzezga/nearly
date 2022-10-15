import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/bloc/tag_bloc.dart';
import 'package:hackathon/ui/read_tag_card.dart';
import 'package:hackathon/ui/tag_details_page.dart';
import '../model/tag.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
              title: const Text("Nearly",
                  style: TextStyle(
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
                        child: ReadTagCard(tag, onTap: () {_showTagSheet(context, tag);}))
                ],
              );
            },
          )),
        ],
      ),
    );
  }

  Future<void> _showTagSheet(BuildContext context, Tag tag) async {
    int? result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SafeArea(
          child: TagDetailsPage(tag),
          ),
        ),
      );

  }
}