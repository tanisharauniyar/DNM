import 'package:dnmm/profile/profile.dart';
import 'package:dnmm/update_visit/update_visit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Add_outlet/Add_outlet.dart';
import '../Calibrate_location/calibrate_location.dart';

class CategoryModel {
  String? name;
  IconData? icon;
  final StatefulWidget? route;

  CategoryModel({this.name, this.icon, this.route});
}

final dashboardLogic = ChangeNotifierProvider<ShowCaseLogic>((ref) {
  return ShowCaseLogic();
});

class ShowCaseLogic extends ChangeNotifier {
  final titlesToShowDialog = [
    "Competitive Item",
    "Collection",
    "Calibrate Location",
    "Monitoring",
    "Movement Analysis",
    "PO Status",
    "Closing Stock",
  ];
  List<CategoryModel> dataList = [
    CategoryModel(
      name: "Profile",
      icon: Icons.pedal_bike,
      route: Profile(),
    ),
    CategoryModel(
      name: "Visit Plan",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Update Visit",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Add Outlet",
      icon: Icons.pedal_bike,
      route: AddOutlet(),
    ),
    CategoryModel(
      name: "Order Booking",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Sales Return",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Update Market Status",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "A/C Statement",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Closing Stock",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "PO Status",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Monitoring",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Movement Analysis",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Calibrate Location",
      icon: Icons.pedal_bike,
      // route: CalibrateLocation(),
    ),
    CategoryModel(
      name: "Collection",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Report",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "End Of Day",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Competitive Item",
      icon: Icons.pedal_bike,
    ),
  ];
}