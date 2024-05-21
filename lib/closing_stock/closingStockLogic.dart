import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final closingStockLogic = ChangeNotifierProvider<ClosingStockLogic>((ref) {
  return ClosingStockLogic();
});

class ClosingStockLogic extends ChangeNotifier {
  final Title = ['GIN', 'Vodka', 'Scotch'];

  List<Map<String, dynamic>> listOrder = [
    {
      "name": "Berries and blue 750 ML",
      "available_units": ["kg", "case", "pcs"],
      "selected_unit": "kg",
      "Closing_Stock": 0.00,
    },
    {
      "name": "Berries and Blue 180 ML",
      "available_units": ["kg", "case", "pcs"],
      "selected_unit": 'kg',
      "Closing_Stock": 0.00,
    },
    {
      "name": "Nepse Bull 750",
      "available_units": ["kg", "case", "pcs"],
      "selected_unit": "kg",
      "Closing_Stock": 0.00,
    },
  ];

  setGroup(int index, String? group) {
    listOrder[index]['selected_unit'] = group!;
    notifyListeners();
  }
}