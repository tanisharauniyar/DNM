import 'package:dnmm/utills/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../Order_booking/order_booking_logic.dart';

class OrderBookingdata extends DataGridSource {
  List<DataGridRow> OrderData = [];

  @override
  List<DataGridRow> get rows => OrderData;

  bool color = false;

  OrderBookingdata({
    required List<order> data,
  }) {
    OrderData = data.map<DataGridRow>(
      (d) {
        return DataGridRow(
          cells: [
            DataGridCell<String>(
              columnName: 'DESCRIPTION',
              value: d.Description,
            ),
            DataGridCell<double>(
              columnName: 'UNIT',
              value: d.Unit ?? 0.00,
            ),
            DataGridCell<double>(
              columnName: 'QTY',
              value: d.QTY,
            ),
            DataGridCell<double>(columnName: 'RATE', value: d.Rate),
            DataGridCell<double>(
              columnName: 'AMT',
              value: d.Rate! * d.QTY!,
            ),
          ],
        );
      },
    ).toList();
  }

  final List<String> areaNames = <String>[
    'PCS',
    'CASE',
  ];

  getColor(String columnName, int index) {
    return Colors.black;
  }

  @override
  Widget? buildGroupCaptionCellWidget(
    RowColumnIndex rowColumnIndex,
    String summaryValue,
  ) {
    return Container(
        color: Themes.defaultGreenColor.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Text(summaryValue));
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'QTY') {
          return Container(
            color: Themes.defaultGreenColor.withOpacity(0.2),
            alignment: Alignment.center,
            padding: EdgeInsets.all(38.r),
            child: TextField(
              controller: TextEditingController(text: e.value.toString()),
              keyboardType: TextInputType.number,
            ),
          );
        } else {
          return Container(
            color: Themes.defaultGreenColor.withOpacity(0.2),
            alignment: Alignment.center,
            padding: EdgeInsets.all(38.r),
            child: Text(e.value.toString()),
          );
        }
      }).toList(),
    );
  }
}

class order {
  order(
    this.Description,
    this.Unit,
    this.QTY,
    this.Rate,
    this.Amt,
  );

  final String Description;
  final double? Unit;
  final double? QTY;
  final double? Rate;
  final double? Amt;
}