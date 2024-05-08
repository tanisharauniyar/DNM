import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'calibrate_location_logic.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(88.0),
                child: Container(
                  height: 120.h,
                  width: 450.w,
                  color: Colors.green,
                  child: Text(
                    ref.watch(calibratelocationLogic).locationMessage ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              20.verticalSpace,
              InkWell(
                onTap: () {
                  print("sfsdf");
                  ref.watch(calibratelocationLogic).location();
                },
                child: Container(
                  height: 80.h,
                  width: 290.w,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      "get current location",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              20.verticalSpace,
              InkWell(
                onTap: () {
                  print("sfs");
                  ref.watch(calibratelocationLogic).openmap(
                      ref.watch(calibratelocationLogic).lat ?? '',
                      ref.watch(calibratelocationLogic).long ?? '');
                },
                child: Container(
                  height: 80.h,
                  width: 290.w,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      "google map",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}