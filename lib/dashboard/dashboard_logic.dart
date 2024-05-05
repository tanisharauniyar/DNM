import 'package:dnmm/Login/login_view.dart';
import 'package:dnmm/profile/profile.dart';
import 'package:dnmm/update_visit/update_visit.dart';
import 'package:dnmm/visit_plan/visit_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  List<CategoryModel> dataList = [
    CategoryModel(
      name: "Profile",
      icon: Icons.pedal_bike,
      route: Profile(),
    ),
    CategoryModel(
      name: "Visit Plan",
      icon: Icons.pedal_bike,
      route: VisitPlan(),
    ),
    CategoryModel(
      name: "Update Visit",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Add Outlet",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Order Booking",
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      name: "Sales Report",
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