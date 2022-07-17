import 'package:flutter/material.dart';

class PerformanceMode extends StatelessWidget {
  const PerformanceMode({Key? key, this.size, required this.mode})
      : super(key: key);
  final Size? size;
  final String mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size?.width ?? 20,
      height: size?.height ?? 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: (mode == "sport" || mode == "sports")
              ? Colors.red
              : (mode == "eco")
                  ? Colors.green
                  : Colors.black),
      child: Center(
        child: Text(
          mode.toUpperCase(),
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
      // color:if(mode=="normal")
    );
  }
}
