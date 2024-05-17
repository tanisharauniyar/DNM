import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderbookingLogic = ChangeNotifierProvider<OrderBookingLogic>((ref) {
  return OrderBookingLogic();
});

class OrderBookingLogic extends ChangeNotifier {
  String? select;
  bool ischecked = false;
  final TabsTitle = ['GIN', 'Vodka', 'Scotch'];

  List<Map<String, dynamic>> listOrder = [
    {
      "name": "Berries and blue 750 ML",
      "available_units": ["kg", "case", "pcs"],
      "selected_unit": "kg",
      "price_list": {"kg": 500.00, "pcs": 50.00, "case": 200.00},
      "active rate": 500.00,
      "quantity": 0.00,
      "amt": 0.00,
      "current stock": 20.00
    },
    {
      "name": "Berries and Blue 180 ML",
      "available_units": ["kg", "case", "pcs"],
      "selected_unit": 'kg',
      "price_list": {"kg": 500, "pcs": 50, "case": 200},
      "active rate": 500.00,
      "quantity": 0.00,
      "amt": 0.00,
      "current stock": 50.00
    },
    {
      "name": "Nepse Bull 750",
      "available_units": ["kg", "case", "pcs"],
      "selected_unit": "kg",
      "price_list": {"kg": 500.00, "pcs": 50.00, "case": 200.00},
      "active rate": 500.00,
      "quantity": 0.00,
      "amt": 0.00,
      "current stock": 70.00
    },
  ];
  checkBox() {
    ischecked = !ischecked;
    notifyListeners();
  }

  setGroup(int index, String? group) {
    listOrder[index]['selected_unit'] = group!;
    listOrder[index]['active rate'] =
        listOrder[index]['price_list'][listOrder[index]['selected_unit']];
    notifyListeners();
  }

  setQtyAndAmt(int index, String? qty) {
    listOrder[index]['quantity'] = qty!;
    double data = double.parse(listOrder[index]['quantity'].toString()) *
        double.parse(listOrder[index]['active rate'].toString());
    listOrder[index]['amt'] = data;
    notifyListeners();
  }
}