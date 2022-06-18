import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ic/screen/guage_props.dart';
import 'package:ic/screen/guage_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double speed = 0;
  double val = 1;
  late Timer timer;
  DateTime currentTime = DateTime.now();
  // var currentTime = "23";

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 10), ((timer) {
      if (speed > 240) val = -0.1;
      if (speed < 1) val = 0.1;
      setState(() {});
      speed += val;
      currentTime = DateTime.now();
    }));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuageProps.bgColor,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // "hello",
                      "${currentTime.day}-${currentTime.month}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 184, 183, 183),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 40),
                    Text(
                      // "hello",
                      "${currentTime.hour}:${currentTime.minute}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 40),
                    const Text(
                      "${23}${"\u2109"}",
                      style: TextStyle(
                          color: Color.fromARGB(255, 184, 183, 183),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomGuage(
                          size: 300,
                          low: 0,
                          high: 240,
                          mainValue: speed,
                          label: "Km/h",
                          zeroTickLabel: "0",
                          maxTickLabel: "240",
                          distTicksBottom: 65,
                          distanceBWTicks: 130,
                          distLabelTop: 75,
                          distMainTop: 120,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "images/image.png",
                            scale: 0.3,
                            width: 120,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomGuage(
                          size: 300,
                          low: 0,
                          high: 500,
                          mainValue: speed + 13,
                          label: "rpm",
                          zeroTickLabel: "0",
                          maxTickLabel: "500",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Flexible(
                  flex: 1,
                  child: Placeholder(
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
