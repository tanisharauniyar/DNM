import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utills/themes.dart';

class DistributorModel {
  final String name;
  final IconData icon;
  final StatefulWidget? route;

  DistributorModel({
    required this.name,
    required this.icon,
    this.route,
  });
}

final UpdateVisitLogic = ChangeNotifierProvider<UpdatevisitLogic>((ref) {
  return UpdatevisitLogic();
});

class UpdatevisitLogic extends ChangeNotifier {
  final List<DistributorModel> Title = [
    DistributorModel(
      name: 'Distributor 1',
      icon: Icons.local_shipping,
    ),
    DistributorModel(
      name: 'Distributor 2',
      icon: Icons.local_shipping,
    ),
    DistributorModel(
      name: 'Distributor 2',
      icon: Icons.local_shipping,
    ),
    DistributorModel(name: 'Distributor 2', icon: Icons.local_shipping),
    DistributorModel(name: 'Distributor 2', icon: Icons.local_shipping),
    DistributorModel(name: 'Distributor 2', icon: Icons.local_shipping),
  ];
}