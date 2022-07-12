import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/vehicle_signal/vehicle_signal_model.dart';
import 'package:ic/vehicle_signal/vehicle_signal_provider.dart';

class PerformanceMode extends ConsumerWidget {
  const PerformanceMode({Key? key, this.size, required this.mode})
      : super(key: key);
  final Size? size;
  final String mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VehicleSignal vehicle = ref.watch(vehicleSignalProvider);
    print(vehicle.performanceMode);
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
