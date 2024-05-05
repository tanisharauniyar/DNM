import 'package:dnmm/utills/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProdVsSalesData extends DataGridSource {
  List<DataGridRow> dataList = [];

  @override
  List<DataGridRow> get rows => dataList;

  bool color = false;

  ProdVsSalesData({
    required List<Report> data,
  }) {
    dataList = data.map<DataGridRow>(
      (d) {
        return DataGridRow(
          cells: [
            DataGridCell<String>(
              columnName: 'Sales',
              value: d.name,
            ),
            // DataGridCell<String>(
            //   columnName: 'MTD sales ',
            //   value: d.name,
            // ),
            // DataGridCell<String>(
            //   columnName: 'YTD sales ',
            //   value: d.name,
            // ),
            DataGridCell<double>(
              columnName: 'TodayTarget',
              value: d.todayTarget ?? 0.00,
            ),
            DataGridCell<double>(
              columnName: 'TodayAchievements',
              value: d.todayAchieved,
            ),
            DataGridCell<double>(columnName: 'MTDTarget', value: d.monthTarget),
            DataGridCell<double>(
                columnName: 'MTDAchievements', value: d.monthAchieved),
            DataGridCell<double>(
              columnName: 'YTDTarget',
              value: d.yearTarget,
            ),
            DataGridCell<double>(
              columnName: 'YTDAchievements',
              value: d.yearAchieved,
            ),
          ],
        );
      },
    ).toList();
  }

  // @override
  // List<String> getProductNames() {
  //   return dataList
  //       .where((row) =>
  //           row.getCells()[0].value != null &&
  //           row.getCells()[0].value != "Sales Target")
  //       .map<String>((row) => row.getCells()[0].value.toString())
  //       .toList();
  // }
  //
  // List<DataGridRow> getFilteredRows(int? selectedProduct) {
  //   if (selectedProduct! < 10000) {
  //     return dataList;
  //   } else {
  //     return dataList
  //         .where((row) => row.getCells()[0].value == selectedProduct)
  //         .toList();
  //   }
  // }

  final List<String> productNames = <String>['Apple', 'Samsung', 'Asus'];
  final List<String> areaNames = <String>[
    'bhaktapur',
    'kathmandu',
    'lalitpur',
  ];
  final List<String> customerNames = <String>[
    'sriya',
    'kritika',
    'lalbahadur',
  ];

  @override
  String performGrouping(String columnName, DataGridRow row) {
    // print(columnName);
    if (columnName == 'Sales') {
      //print("testing");

      String headerValue = row
          .getCells()
          .firstWhere(
            (cell) => cell.columnName == 'Sales',
            orElse: () => DataGridCell<String>(columnName: '', value: ''),
          )
          .value;
      print("headerValue");
      print(headerValue);
      print(productNames.contains(headerValue));
      print("productNames.contains(headerValue)");

      if (productNames.contains(headerValue)) {
        print(headerValue);
        return 'Product wise';
      } else if (areaNames.contains(headerValue)) {
        return 'Area wise';
      } else if (customerNames.contains(headerValue)) {
        return 'Customer wise';
      }
    }

    return super.performGrouping(columnName, row);
  }

  ///
  // String performGrouping(String columnName, DataGridRow row) {
  //   if (columnName == 'Header') {
  //     if (row.getCells()[0].value <= 10) {
  //       return '<= 10';
  //     } else {
  //       return '> 10';
  //     }
  //   }
  //   return super.performGrouping(columnName, row);
  // }

  // String performGrouping(String columnName, DataGridRow row) {
  //   if (columnName == "Header") {
  //     String firstLetter =
  //         row.getCells()[0].getValue().toString().substring(0, 1).toUpperCase();
  //     if (firstLetter.matches("[A-C]")) {
  //       return firstLetter;
  //     } else {
  //       // Words starting with letters other than a, b, or c
  //       return "Other";
  //     }
  //   }
  //   return super.performGrouping(columnName, row);
  // }

  @override
  Widget? buildGroupCaptionCellWidget(
      RowColumnIndex rowColumnIndex, String summaryValue) {
    return Container(
        color: Themes.defaultGreenColor.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Text(summaryValue));
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final int index = effectiveRows.indexOf(row);
      if (dataGridCell.columnName == "Products") {
        return Container(
          color: getColor(dataGridCell.columnName, index),
          padding: EdgeInsets.only(left: 30.r, right: 30.r),
          alignment: (dataGridCell.columnName == "Products" ||
                  dataGridCell.columnName == "Unit")
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(left: (dataGridCell.value['level'] * 13.0)),
            child: Text(
              dataGridCell.value['data'].toString(),
              maxLines: 2,
              style: TextStyle(
                  fontSize: 40.r,
                  fontWeight: FontWeight.w500,
                  // color: Colors.black.withOpacity(
                  //   0.9,
                  // ),
                  color: Colors.blueAccent),
            ),
          ),
        );
      } else {
        final int index = effectiveRows.indexOf(row);
        print(index);
        return Container(
          color: (index == 0 || index == 12)
              ? Themes.defaultLightGreenColor
              : Themes.defaultLightBGColor,
          padding: EdgeInsets.only(left: 30.r, right: 30.r),
          alignment: (dataGridCell.columnName == "Products" ||
                  dataGridCell.columnName == "Unit")
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Text(
            dataGridCell.value.toString(),
            style: (index == 0 || index == 12)
                ? TextStyle(
                    fontSize: 46.r,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(
                      0.9,
                    ),
                  )
                : TextStyle(
                    fontSize: 40.r,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(
                      0.9,
                    ),
                  ),
          ),
        );
      }
    }).toList());
  }

  getColor(String columnName, int index) {
    return Colors.black;
  }

  getName(int level, String name) {
    // if (name == null) {
    //   return "null";
    // }
    // String n = "";
    // for (int i = 0; i < level; i++) {
    //   n = "$n     ";
    // }
    // n = n + name;
    return {
      "data": name,
      "level": level,
    };
  }
}

class Report {
  Report(this.name, this.todayTarget, this.todayAchieved, this.monthTarget,
      this.monthAchieved, this.yearTarget, this.yearAchieved);

  final String name;
  final double? todayTarget;
  final double? todayAchieved;
  final double? monthTarget;
  final double? monthAchieved;
  final double? yearTarget;
  final double? yearAchieved;
}