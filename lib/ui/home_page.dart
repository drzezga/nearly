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

import 'dart:io';

import 'package:flutter/services.dart';

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
  StreamSubscription<BluetoothState>? _streamBluetooth;

  @override
  void initState() {
    super.initState();

    listeningState();

    // WidgetsBinding.instance?.addObserver(this);

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null) {
        if (_streamBluetooth!.isPaused) {
          _streamBluetooth?.resume();
        }
      }
      await checkAllRequirements();
    } else if (state == AppLifecycleState.paused) {
      _streamBluetooth?.pause();
    }
  }

  listeningState() async {
    print('Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      controller.updateBluetoothState(state);
      await checkAllRequirements();
    });
  }

  checkAllRequirements() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    controller.updateBluetoothState(bluetoothState);
    print('BLUETOOTH $bluetoothState');

    final authorizationStatus = await flutterBeacon.authorizationStatus;
    controller.updateAuthorizationStatus(authorizationStatus);
    print('AUTHORIZATION $authorizationStatus');

    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;
    controller.updateLocationService(locationServiceEnabled);
    print('LOCATION SERVICE $locationServiceEnabled');

    if (controller.bluetoothEnabled &&
        controller.authorizationStatusOk &&
        controller.locationServiceEnabled) {
      print('STATE READY');
      controller.startScanning();
    } else {
      print('STATE NOT READY');
      controller.pauseScanning();
    }
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
          for (var list in _regionBeacons.values) {
            _beacons.addAll(list);
            for (var beacon in list) {
              context.read<TagBloc>().add(TagReadEvent(
                  beacon.proximityUUID, beacon.minor, beacon.major));
            }
          }
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
    _streamBluetooth?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
              title: const Text("Nearly",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800)),
              titleSpacing: 0,
              actions: [
                if (!controller.authorizationStatusOk || !controller.locationServiceEnabled) Obx(() {
                  if (!controller.locationServiceEnabled) {
                    return IconButton(
                      tooltip: 'Not Determined',
                      icon: const Icon(Icons.portable_wifi_off),
                      color: Colors.grey,
                      onPressed: () {},
                    );
                  }

                  if (!controller.authorizationStatusOk) {
                    return IconButton(
                      tooltip: 'Not Authorized',
                      icon: const Icon(Icons.portable_wifi_off),
                      color: Colors.red,
                      onPressed: () async {
                        await flutterBeacon.requestAuthorization;
                      },
                    );
                  }

                  return IconButton(
                    tooltip: 'Authorized',
                    icon: Icon(Icons.wifi_tethering),
                    color: Colors.blue,
                    onPressed: () async {
                      await flutterBeacon.requestAuthorization;
                    },
                  );
                }),
                if (!controller.locationServiceEnabled) Obx(() {
                  return IconButton(
                    tooltip: controller.locationServiceEnabled
                        ? 'Location Service ON'
                        : 'Location Service OFF',
                    icon: Icon(
                      controller.locationServiceEnabled
                          ? Icons.location_on
                          : Icons.location_off,
                    ),
                    color: controller.locationServiceEnabled
                        ? Colors.blue
                        : Colors.red,
                    onPressed: controller.locationServiceEnabled
                        ? () {}
                        : handleOpenLocationSettings,
                  );
                }),
                if (controller.bluetoothState.value != BluetoothState.stateOn) Obx(() {
                  final state = controller.bluetoothState.value;

                  if (state == BluetoothState.stateOn) {
                    return IconButton(
                      tooltip: 'Bluetooth ON',
                      icon: Icon(Icons.bluetooth_connected),
                      onPressed: () {},
                      color: Colors.lightBlueAccent,
                    );
                  }

                  if (state == BluetoothState.stateOff) {
                    return IconButton(
                      tooltip: 'Bluetooth OFF',
                      icon: Icon(Icons.bluetooth),
                      onPressed: handleOpenBluetooth,
                      color: Colors.red,
                    );
                  }

                  return IconButton(
                    icon: Icon(Icons.bluetooth_disabled),
                    tooltip: 'Bluetooth State Unknown',
                    onPressed: () {},
                    color: Colors.grey,
                  );
                }),
                IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            //     builder: (context) => BlocProvider(create: (_) => NotificationPreferencesCubit(), child: const SettingsPage())),
                              builder: (_) => const SettingsPage()))
                    }),
              ]),
          SliverToBoxAdapter(child: BlocBuilder<TagBloc, List<Tag>>(
            builder: (context, state) {
              return Column(
                children: [
                  for (var tag in state)
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: ReadTagCard(tag, onTap: () {
                          _showTagSheet(context, tag);
                        })),
                  if (state.isEmpty)
                    SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.question_mark),
                            SizedBox(
                              height: 20,
                            ),
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

  handleOpenLocationSettings() async {
    if (Platform.isAndroid) {
      await flutterBeacon.openLocationSettings;
    } else if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Location Services Off'),
            content: Text(
              'Please enable Location Services on Settings > Privacy > Location Services.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  handleOpenBluetooth() async {
    if (Platform.isAndroid) {
      try {
        await flutterBeacon.openBluetoothSettings;
      } on PlatformException catch (e) {
        print(e);
      }
    } else if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bluetooth is Off'),
            content: Text('Please enable Bluetooth on Settings > Bluetooth.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
