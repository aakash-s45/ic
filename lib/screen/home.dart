// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cluster_dashboard/map/navigationHome.dart';
import 'package:flutter_cluster_dashboard/provider.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/guages/guage_props.dart';
import 'package:flutter_cluster_dashboard/screen/paints/bottombar_paint.dart';
import 'package:flutter_cluster_dashboard/screen/paints/topbar_paint.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/guages/rpm_guage_animation_wrapper.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/left_bar.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/performance_mode.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/right_bar.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/guages/speed_guage_animation_wrapper.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/signals.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/turn_signal.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_provider.dart';
import 'package:intl/intl.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);
  GuageColors? getGuageColor(String mode) {
    return (mode == "economy")
        ? GuageProps.ecoModeColor
        : (mode == "sport")
            ? GuageProps.sportModeColor
            : null;
  }

  String addZero(int val) {
    String res = val.toString();
    if (res.length < 2) {
      if (res.isEmpty) {
        return "00";
      } else if (res.length == 1) {
        return "0$res";
      }
    }
    return res;
  }

  double calcPadding(double value, double height) {
    // values wrt to values at 720 height
    return (value * height) / 720;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(vehicleSignalProvider);
    final clock = ref.watch(clockProvider);
    final windowHeight = MediaQuery.of(context).size.height;
    final windowWidth = MediaQuery.of(context).size.width;

    double screenHeight = windowHeight;
    double screenWidth = windowWidth;

    double ratHeight = (windowWidth * 9) / 16;
    double ratWidth = (windowHeight * 16) / 9;

    if (ratWidth <= windowWidth) {
      screenHeight = windowHeight;
      screenWidth = ratWidth;
    } else {
      screenHeight = ratHeight;
      screenWidth = windowWidth;
    }

    return Scaffold(
      backgroundColor: GuageProps.bgColor,
      body: SafeArea(
        child: Center(
          child: Center(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //TopBarPainter
                  Flexible(
                    flex: 1,
                    child: Stack(
                      children: [
                        TurnSignal(
                          screenHeight: screenHeight,
                          isLefton: vehicle.isLeftIndicator,
                          isRighton: vehicle.isRightIndicator,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // mid section of top bar
                            Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: (400 * screenHeight) / 480,
                                height: (65 * screenHeight) / 480,
                                child: CustomPaint(
                                  painter: TopBarPainter(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('EEEE')
                                            .format(clock)
                                            .substring(0, 3),
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 184, 183, 183),
                                            fontSize: (20 * screenHeight) / 480,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                          width: (40 * screenHeight) / 480),
                                      Text(
                                        "${clock.hour}:${addZero(clock.minute)}",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: (30 * screenHeight) / 480,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                          width: (30 * screenHeight) / 480),
                                      Text(
                                        "${vehicle.ambientAirTemp} ${"\u00B0"}C",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 184, 183, 183),
                                            fontSize: (20 * screenHeight) / 480,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // mid section
                  Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Stack(
                      children: [
                        //left and right arc
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              calcPadding(60, screenHeight),
                              calcPadding(60, screenHeight),
                              calcPadding(60, screenHeight),
                              0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  LeftArc(screenHeight: screenHeight),
                                  Positioned(
                                    child: Image.asset(
                                      "images/temperature-icon.png",
                                      color: Colors.white,
                                      width: (13 * screenHeight) / 480,
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  RightArc(screenHeight: screenHeight),
                                  Positioned(
                                      child: Image.asset(
                                    "images/fuel-icon.png",
                                    color: Colors.white,
                                    width: (18 * screenHeight) / 480,
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        //logo area
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              calcPadding(60, screenHeight),
                              calcPadding(10, screenHeight),
                              calcPadding(60, screenHeight),
                              0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: (550 * screenHeight) / 720,
                                height: (450 * screenHeight) / 720,
                                child: Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // performance mode
                                    Flexible(
                                      flex: 1,
                                      child: PerformanceMode(
                                          size: Size((90 * screenHeight) / 480,
                                              (20 * screenHeight) / 480),
                                          mode: vehicle.performanceMode),
                                    ),
                                    // logo
                                    Flexible(
                                      flex: 6,
                                      fit: FlexFit.tight,
                                      child: SizedBox(
                                        width: (330 * screenHeight) / 720,
                                        child: (vehicle.isSteeringInfo)
                                            ? const NavigationHome()
                                            : Padding(
                                                padding: EdgeInsets.all(
                                                    (48.0 * screenHeight) /
                                                        720),
                                                child: Image.asset(
                                                  "images/logo_agl.png",
                                                  width:
                                                      (90 * screenHeight) / 480,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                      ),
                                    ),
                                    const Flexible(
                                      flex: 1,
                                      child: SizedBox(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //warning signals
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              calcPadding(0, screenHeight),
                              calcPadding(430, screenHeight),
                              calcPadding(0, screenHeight),
                              0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Signals(
                                screenHeight: screenHeight,
                                vehicle: vehicle,
                              ),
                            ],
                          ),
                        ),
                        // guages
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              calcPadding(70, screenHeight),
                              calcPadding(30, screenHeight),
                              calcPadding(70, screenHeight),
                              0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Speed Guage
                              SpeedGauge(
                                screenHeight: screenHeight,
                                guageColor:
                                    getGuageColor(vehicle.performanceMode),
                              ),
                              //RPM Guage
                              RPMGauge(
                                screenHeight: screenHeight,
                                guageColor:
                                    getGuageColor(vehicle.performanceMode),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // bottomBarPainter
                  Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: (400 * screenHeight) / 480,
                        height: (50 * screenHeight) / 480,
                        child: CustomPaint(
                          size: Size((400 * screenHeight) / 480,
                              (50 * screenHeight) / 480),
                          painter: BottomBarPainter(),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                (vehicle.selectedGear == Gear.parking)
                                    ? Text("P",
                                        style: GuageProps.activeGearIconStyle(
                                            screenHeight))
                                    : Text("P",
                                        style: GuageProps.gearIconStyle(
                                            screenHeight)),
                                (vehicle.selectedGear == Gear.reverse)
                                    ? Text("R",
                                        style: GuageProps.activeGearIconStyle(
                                            screenHeight))
                                    : Text("R",
                                        style: GuageProps.gearIconStyle(
                                            screenHeight)),
                                (vehicle.selectedGear == Gear.neutral)
                                    ? Text("N",
                                        style: GuageProps.activeGearIconStyle(
                                            screenHeight))
                                    : Text("N",
                                        style: GuageProps.gearIconStyle(
                                            screenHeight)),
                                (vehicle.selectedGear == Gear.drive)
                                    ? Text("D",
                                        style: GuageProps.activeGearIconStyle(
                                            screenHeight))
                                    : Text("D",
                                        style: GuageProps.gearIconStyle(
                                            screenHeight)),
                              ]),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
