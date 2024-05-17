import 'package:dnmm/Calibrate_location/calibrate_location.dart';
import 'package:dnmm/profile/profile.dart';
import 'package:dnmm/update_visit/update_visit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Add_outlet/Add_outlet.dart';
import '../Calibrate_location/outlet.dart';
import '../Order_booking/Order.dart';
import '../Order_booking/order_booking_outlet.dart';
import '../closing_stock/closingStock.dart';
import '../collection/collection.dart';

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
  String? onselect;

  final titlesToShowDialog = {
    "Competitive Item": {
      "Distributor": UpdateVisitView(),
      "Outlet": UpdateVisitView(),
    },
    "Collection": {
      "Distributor": const Collection(
        label: 'Distributor',
      ),
      "Outlet": const Collection(
        label: 'Outlet',
      ),
    },
    "Calibrate Location": {"Distributor": MapScreen(), "Outlet": MapScreen()},
    "Monitoring": {"Distributor": UpdateVisitView(), "Outlet": Outlet()},
    "Movement Analysis": {"Distributor": UpdateVisitView(), "Outlet": Outlet()},
    "PO status": {"Distributor": UpdateVisitView(), "Outlet": Outlet()},
    "Closing Stock": {"Distributor": ClosingStock(), "Outlet": Outlet()},
    "Order Booking": {"Distributor": Order(), "Outlet": OrderOutlet()},
  };

  List<CategoryModel> dataList = [
    CategoryModel(
      name: "Profile",
      icon: Icons.pedal_bike,
      route: Profile(),
    ),
    CategoryModel(
      name: "Visit Plan",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
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
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Sales Return",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Update Market Status",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "A/C Statement",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Closing Stock",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "PO Status",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Monitoring",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Movement Analysis",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Calibrate Location",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),

      // route: CalibrateLocation(),
    ),
    CategoryModel(
      name: "Collection",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Report",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "End Of Day",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
    CategoryModel(
      name: "Competitive Item",
      icon: Icons.pedal_bike,
      route: UpdateVisitView(),
    ),
  ];
}