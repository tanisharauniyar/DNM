import 'package:dnmm/Calibrate_location/calibrate_location.dart';
import 'package:dnmm/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Add_outlet/Add_outlet.dart';
import '../Extra_page/New_page.dart';
import '../Order_booking/Order.dart';
import '../Order_booking/order_booking_outlet.dart';
import '../Update_visit/Update_visit_dialogue.dart';
import '../Update_visit/latitude_logitude_show.dart';
import '../closing_stock/closingStock.dart';
import '../collection/collection.dart';

class CategoryModel {
  String? name;
  IconData? icon;
  List<Map> routeData = [];
  final StatefulWidget? route;

  CategoryModel({this.name, this.icon, this.route, this.routeData = const []});
}

final dashboardLogic = ChangeNotifierProvider<ShowCaseLogic>((ref) {
  return ShowCaseLogic();
});

class ShowCaseLogic extends ChangeNotifier {
  String? onselect;

  List<CategoryModel> dataList = [
    CategoryModel(
      name: "Profile",
      icon: Icons.pedal_bike,
      route: Profile(),
    ),
    CategoryModel(
      name: "Visit Plan",
      icon: Icons.pedal_bike,
      route: NewPage(),
    ),
    CategoryModel(
      name: "Update Visit",
      icon: Icons.pedal_bike,
      route: NewPage(),
      routeData: [
        {
          "name": "Distributor",
          "route": UpdateVisitDistributor(),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Outlet",
          "route": OrderOutlet(),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Others",
          "route": Order(),
          'icon': Icons.ac_unit_rounded,
        }
      ],
    ),
    CategoryModel(
      name: "Add Outlet",
      icon: Icons.pedal_bike,
      route: AddOutlet(),
    ),
    CategoryModel(
      name: "Order Booking",
      icon: Icons.pedal_bike,
      route: NewPage(),
      routeData: [
        {
          "name": "Distributor",
          "route": Order(),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Outlet",
          "route": OrderOutlet(),
          'icon': Icons.ac_unit_rounded,
        }
      ],
    ),
    CategoryModel(
      name: "Sales Return",
      icon: Icons.pedal_bike,
      route: LatLong(),
    ),
    CategoryModel(
      name: "Update Market Status",
      icon: Icons.pedal_bike,
      route: NewPage(),
    ),
    CategoryModel(
      name: "A/C Statement",
      icon: Icons.pedal_bike,
      route: NewPage(),
    ),
    CategoryModel(
      name: "Closing Stock",
      icon: Icons.pedal_bike,
      route: NewPage(),
      routeData: [
        {
          "name": "Distributor",
          "route": ClosingStock(),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Outlet",
          "route": ClosingStock(),
          'icon': Icons.ac_unit_rounded,
        }
      ],
    ),
    CategoryModel(
      name: "PO Status",
      icon: Icons.pedal_bike,
      route: NewPage(),
      routeData: [
        {
          "name": "Distributor",
          "route": NewPage(),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Outlet",
          "route": NewPage(),
          'icon': Icons.ac_unit_rounded,
        }
      ],
    ),
    CategoryModel(
      name: "Monitoring",
      icon: Icons.pedal_bike,
      route: NewPage(),
      routeData: [
        {
          "name": "Distributor",
          "route": NewPage(),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Outlet",
          "route": NewPage(),
          'icon': Icons.ac_unit_rounded,
        }
      ],
    ),
    CategoryModel(
      name: "Movement Analysis",
      icon: Icons.pedal_bike,
      route: NewPage(),
      routeData: [
        {
          "name": "Distributor",
          "route": NewPage(),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Outlet",
          "route": NewPage(),
          'icon': Icons.ac_unit_rounded,
        }
      ],
    ),
    CategoryModel(
      name: "Calibrate Location",
      icon: Icons.pedal_bike,
      route: NewPage(),
      routeData: [
        {
          "name": "Distributor",
          "route": MapScreen(),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Outlet",
          "route": MapScreen(),
          'icon': Icons.ac_unit_rounded,
        }
      ],
    ),
    CategoryModel(
      name: "Collection",
      icon: Icons.pedal_bike,
      route: NewPage(),
      routeData: [
        {
          "name": "Distributor",
          "route": const Collection(
            label: 'Distributor',
          ),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Outlet",
          "route": const Collection(
            label: 'Outlet',
          ),
          'icon': Icons.ac_unit_rounded,
        },
      ],
    ),
    CategoryModel(
      name: "Report",
      icon: Icons.pedal_bike,
      route: NewPage(),
    ),
    CategoryModel(
      name: "End Of Day",
      icon: Icons.pedal_bike,
      route: NewPage(),
    ),
    CategoryModel(
      name: "Competitive Item",
      icon: Icons.pedal_bike,
      route: NewPage(),
      routeData: [
        {
          "name": "Distributor",
          "route": NewPage(),
          'icon': Icons.ac_unit_rounded,
        },
        {
          "name": "Outlet",
          "route": NewPage(),
          'icon': Icons.ac_unit_rounded,
        }
      ],
    ),
  ];
}