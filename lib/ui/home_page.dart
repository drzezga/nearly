import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/bloc/tag_bloc.dart';
import 'package:hackathon/ui/read_tag_card.dart';
import 'package:hackathon/ui/tag_details_page.dart';
import '../model/tag.dart';
import 'settings_page.dart';

import 'package:flutter_beacon/flutter_beacon.dart';
import '../controller/requirement_state_controller.dart';
import 'package:get/get.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  StreamSubscription<RangingResult>? _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  final controller = Get.find<RequirementStateController>();

  @override
  void initState() {
  super.initState();

  controller.startStream.listen((flag) {
  if (flag == true) {
  initScanBeacon();
  }
  });

  controller.pauseStream.listen((flag) {
  if (flag == true) {
  pauseScanBeacon();
  }
  });
  }

  initScanBeacon() async {
  await flutterBeacon.initializeScanning;
  if (!controller.authorizationStatusOk ||
  !controller.locationServiceEnabled ||
  !controller.bluetoothEnabled) {
  print(
  'RETURNED, authorizationStatusOk=${controller.authorizationStatusOk}, '
  'locationServiceEnabled=${controller.locationServiceEnabled}, '
  'bluetoothEnabled=${controller.bluetoothEnabled}');
  return;
  }
  final regions = <Region>[
  Region(
  identifier: 'Cubeacon',
  proximityUUID: 'CB10023F-A318-3394-4199-A8730C7C1AEC',
  ),
  Region(
  identifier: 'BeaconType2',
  proximityUUID: '6a84c716-0f2a-1ce9-f210-6a63bd873dd9',
  ),
  ];

  if (_streamRanging != null) {
  if (_streamRanging!.isPaused) {
  _streamRanging?.resume();
  return;
  }
  }

  _streamRanging =
  flutterBeacon.ranging(regions).listen((RangingResult result) {
  print(result);
  if (mounted) {

  setState(() {
  _regionBeacons[result.region] = result.beacons;
  _beacons.clear();
  _regionBeacons.values.forEach((list) {
  _beacons.addAll(list);
  });
  _beacons.sort(_compareParameters);
  });
  }
  });
  }

  pauseScanBeacon() async {
  _streamRanging?.pause();
  if (_beacons.isNotEmpty) {
  setState(() {
  _beacons.clear();
  });
  }
  }

  int _compareParameters(Beacon a, Beacon b) {
  int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
    compare = a.major.compareTo(b.major);
    }

    if (compare == 0) {
    compare = a.minor.compareTo(b.minor);
    }

    return compare;
  }

  @override
  void dispose() {
  _streamRanging?.cancel();
  super.dispose();
  }




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
                        child: ReadTagCard(tag, onTap: () {_showTagSheet(context, tag);})),
                  if (state.isEmpty) SizedBox(height: 200, child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.question_mark),
                      SizedBox(height: 20,),
                      Text("Nie wykryto żadnych komunikatów"),
                    ],
                  ))
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