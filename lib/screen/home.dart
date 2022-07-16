import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/provider.dart';
import 'package:ic/screen/guage_props.dart';
import 'package:ic/screen/paints/bottombar_paint.dart';
import 'package:ic/screen/paints/topbar_paint.dart';
import 'package:ic/screen/widgets/left_bar.dart';
import 'package:ic/screen/widgets/left_signal.dart';
import 'package:ic/screen/widgets/performance_mode.dart';
import 'package:ic/screen/widgets/right_bar.dart';
import 'package:ic/screen/widgets/right_signal.dart';
import 'package:ic/screen/widgets/rpm_guage_animation_wrapper.dart';
import 'package:ic/screen/widgets/speed_guage_animation_wrapper.dart';
import 'package:ic/vehicle_signal/vehicle_signal_provider.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);
  GuageColors? getGuageColor(String mode) {
    return (mode == "economy")
        ? GuageProps.ecoModeColor
        : (mode == "sport")
            ? GuageProps.sportModeColor
            : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(vehicleSignalProvider);
    final clock = ref.watch(clockProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: GuageProps.bgColor,
      body: SafeArea(
        child: Center(
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TopBarPainter
              Flexible(
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // left turn
                    Flexible(
                      flex: 2,
                      child: (vehicle.isLeftIndicator)
                          ? LeftSignal(screenHeight: screenHeight)
                          : Image.asset(
                              "images/left.png",
                              color: const Color.fromARGB(255, 49, 48, 48),
                              width: 0.125 * screenHeight,
                              // width: 60,
                            ),
                    ),
                    // mid section of top bar
                    Flexible(
                      flex: 3,
                      child: SizedBox(
                        width: (400 * screenHeight) / 480,
                        height: (70 * screenHeight) / 480,
                        child: CustomPaint(
                          painter: TopBarPainter(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${clock.day}-${clock.month}",
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 184, 183, 183),
                                    fontSize: (20 * screenHeight) / 480,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: (40 * screenHeight) / 480),
                              Text(
                                "${clock.hour}:${clock.minute}",
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: (30 * screenHeight) / 480,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: (30 * screenHeight) / 480),
                              Text(
                                "${vehicle.ambientAirTemp} ${"\u2109"}",
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
                    // right turn
                    Flexible(
                      flex: 2,
                      child: (vehicle.isRightIndicator)
                          ? RightSignal(screenHeight: screenHeight)
                          : Image.asset(
                              "images/right.png",
                              color: const Color.fromARGB(255, 49, 48, 48),
                              width: 0.125 * screenHeight,
                            ),
                    ),
                  ],
                ),
              ),
              // mid section
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Flex(
                  clipBehavior: Clip.none,
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // LeftPainter
                    Flexible(
                      flex: 3,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          LeftArc(screenHeight: screenHeight),
                          Positioned(
                            child: Image.asset(
                              "images/engine-coolant.png",
                              color: Colors.white,
                              width: (20 * screenHeight) / 480,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Guage 1
                    Flexible(
                        flex: 10,
                        child: SpeedGauge(
                          screenHeight: screenHeight,
                          guageColor: getGuageColor(vehicle.performanceMode),
                        )),
                    //logo area
                    Flexible(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // performance mode
                          Flexible(
                            flex: 1,
                            child: PerformanceMode(
                                size: Size((100 * screenHeight) / 480, 30),
                                mode: vehicle.performanceMode),
                          ),
                          // logo
                          Flexible(
                            flex: 2,
                            child: Image.asset(
                              "images/logo_agl.png",
                              width: (90 * screenHeight) / 480,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Wrap(
                              spacing: 14,
                              runAlignment: WrapAlignment.spaceBetween,
                              alignment: WrapAlignment.spaceEvenly,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (vehicle.isLowBeam)
                                  Image.asset("images/low-beam.png",
                                      color: Colors.white,
                                      width: (20 * screenHeight) / 480),
                                if (vehicle.isHighBeam)
                                  Image.asset("images/high-beam.png",
                                      color: Colors.white,
                                      width: (20 * screenHeight) / 480),
                                if (vehicle.isHazardLightOn)
                                  Image.asset("images/hazard.png",
                                      color: Colors.white,
                                      width: (20 * screenHeight) / 480),
                                if (vehicle.isParkingOn)
                                  Image.asset("images/parking.png",
                                      color: Colors.white,
                                      width: (20 * screenHeight) / 480),
                                if (!vehicle.isBatteryCharging)
                                  Image.asset("images/battery.png",
                                      color: Colors.white,
                                      width: (20 * screenHeight) / 480),
                                if (vehicle.isMILon)
                                  Image.asset("images/malfunction.png",
                                      color: Colors.white,
                                      width: (20 * screenHeight) / 480),
                                if (vehicle.isCruiseControlActive)
                                  Image.asset("images/cruise.png",
                                      color: Colors.white,
                                      width: (20 * screenHeight) / 480),
                                if (vehicle.isCruiseControlError)
                                  Image.asset("images/cruise.png",
                                      color: Colors.red,
                                      width: (20 * screenHeight) / 480),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // Guage 2
                    Flexible(
                        flex: 10,
                        child: RPMGauge(
                          screenHeight: screenHeight,
                          guageColor: getGuageColor(vehicle.performanceMode),
                        )),
                    // RightPainter
                    Flexible(
                      flex: 3,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          RightArc(screenHeight: screenHeight),
                          Positioned(
                              child: Image.asset(
                            "images/fuel.png",
                            color: Colors.white,
                            width: (20 * screenHeight) / 480,
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // bottomBarPainter
              Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: (400 * screenHeight) / 480,
                    height: (60 * screenHeight) / 480,
                    child: CustomPaint(
                      size: Size((400 * screenHeight) / 480,
                          (60 * screenHeight) / 480),
                      painter: BottomBarPainter(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (vehicle.selectedGear == Gear.parking)
                                ? const Text("P",
                                    style: GuageProps.activeGearIconStyle)
                                : const Text("P",
                                    style: GuageProps.gearIconStyle),
                            (vehicle.selectedGear == Gear.reverse)
                                ? const Text("R",
                                    style: GuageProps.activeGearIconStyle)
                                : const Text("R",
                                    style: GuageProps.gearIconStyle),
                            (vehicle.selectedGear == Gear.neutral)
                                ? const Text("N",
                                    style: GuageProps.activeGearIconStyle)
                                : const Text("N",
                                    style: GuageProps.gearIconStyle),
                            (vehicle.selectedGear == Gear.drive)
                                ? const Text("D",
                                    style: GuageProps.activeGearIconStyle)
                                : const Text("D",
                                    style: GuageProps.gearIconStyle),
                          ]),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

/*
x/480=16/9
*/
