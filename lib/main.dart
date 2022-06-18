import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ic/screen/home.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: Home(),
      ),
    ),
  );
}

class Home1 extends StatelessWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Image.asset("images/image.png"),
      )
          // child: SvgPicture.network(
          //   "https://img.icons8.com/material/24/undefined/headlight.png",
          //   // color: Colors.yellow,
          // ),
          ),
    );
  }
}
