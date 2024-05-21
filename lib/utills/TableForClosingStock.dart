import 'package:dnmm/utills/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import '../closing_stock/closingStockLogic.dart';

class ClosingTable extends ConsumerStatefulWidget {
  const ClosingTable({super.key});

  @override
  ConsumerState<ClosingTable> createState() => _ClosingTableState();
}

class _ClosingTableState extends ConsumerState<ClosingTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.h),
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 400.r,
        rightHandSideColumnWidth: 430.h,
        isFixedHeader: true,
        headerWidgets: TableTitleName(),
        leftSideItemBuilder: FixedColumn,
        rightSideItemBuilder: ScrollableColumn,
        itemCount: ref.watch(closingStockLogic).listOrder.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black,
          height: 0.00,
          thickness: 1.0,
        ),
      ),
    );
  }

  List<Widget> TableTitleName() {
    return [
      TableHeaderName(
        'Description',
        450.r,
      ),
      TableHeaderName(
        'Unit',
        310.r,
      ),
      TableHeaderName(
        'Closing Stock',
        370.r,
      ),
    ];
  }

  Widget TableHeaderName(String label, double width) {
    return Container(
      width: width,
      height: 120.h,
      decoration: const BoxDecoration(color: Themes.defaultGreenColor),
      child: Center(
          child: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 50.r, color: Colors.white),
      )),
    );
  }

  Color getRowColor(int index) {
    if (index % 2 == 0) {
      return Themes.lightGreen.withOpacity(0.2);
    } else {
      return Themes.darkGreenHeader.withOpacity(0.2);
    }
  }

  Widget FixedColumn(BuildContext context, int index) {
    return Container(
      width: 450.r,
      height: 100.h,
      color: getRowColor(index),
      child: Center(
        child: Text(
          ref.watch(closingStockLogic).listOrder[index]['name'].toString() ??
              '',
          style: Themes.tableData.copyWith(
            fontSize: 40.r,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget ScrollableColumn(BuildContext context, int index) {
    return Container(
      color: getRowColor(index),
      child: Row(
        children: <Widget>[
          Container(
            width: 310.r,
            height: 100.h,
            // color: getRowColor(index),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 71.r),
              child: CustomDropdown(
                Select: 'Unit',
                value: ref
                    .watch(closingStockLogic)
                    .listOrder[index]['selected_unit']
                    .toString(),
                items: ref.watch(closingStockLogic).listOrder[index]
                    ['available_units'] as List<String>,
                onChanged: (newValue) {
                  if (newValue != null) {
                    ref.read(closingStockLogic).setGroup(index, newValue);
                  }
                },
              ),
            ),
          ),
          Container(
            width: 370.r,
            height: 100.h,
            // color: getRowColor(index),
            child: Center(
              child: customtextfield(
                text: ref
                        .watch(closingStockLogic)
                        .listOrder[index]['Closing_Stock']
                        .toString() ??
                    '',
                keyboardType: TextInputType.phone,
                onUpdate: (qty) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomDropdown({
    String? text,
    String? Select,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          hint: Center(
            child: Text(
              Select ?? "",
              style: TextStyle(
                fontSize: 40.r,
              ),
            ),
          ),
          value: value,
          onChanged: onChanged,
          decoration: const InputDecoration(border: InputBorder.none),
          items: items.map((val) {
            return DropdownMenuItem<String>(
              value: val.toString(),
              child: Center(
                child: Text(
                  val.toString(),
                  style: TextStyle(fontSize: 40.r, fontWeight: FontWeight.w700),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  customtextfield({
    bool editable = true,
    TextEditingController? controller1,
    String? text,
    TextInputType? keyboardType,
    required Function onUpdate,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Center(
        child: TextField(
          textAlign: TextAlign.right,
          keyboardType: keyboardType,
          controller: controller1,
          onChanged: (String? value) {
            onUpdate(value);
          },
          cursorColor: Themes.darkPrimaryColor,
          decoration: InputDecoration(
            enabled: editable,
            hintText: text,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Themes.darkPrimaryColor,
                width: 5.r,
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Themes.darkPrimaryColor,
                width: 5.r,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Themes.primaryColor, width: 5.r),
            ),
          ),
        ),
      ),
    );
  }

  showDialogBox() {
    return showDialog(
      context: context,
      builder: (
        context,
      ) {
        return AlertDialog(
          title: Text(
            'Details',
            style: TextStyle(
              fontSize: 70.r,
              fontWeight: FontWeight.bold,
              color: Themes.darkGreenHeader,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: Text(
                    'Current Stock :',
                    style: TextStyle(
                      fontSize: 60.r,
                      fontWeight: FontWeight.bold,
                      color: Themes.darkPrimaryColor,
                    ),
                  ),
                  title: Text(
                    '20',
                    style: TextStyle(
                      fontSize: 40.r,
                      fontWeight: FontWeight.bold,
                      color: Themes.darkPrimaryColor,
                    ),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Location :',
                    style: TextStyle(
                      fontSize: 60.r,
                      fontWeight: FontWeight.bold,
                      color: Themes.darkPrimaryColor,
                    ),
                  ),
                  title: Text(
                    'Kathmandu, jhamsikhel',
                    style: TextStyle(
                      fontSize: 40.r,
                      fontWeight: FontWeight.bold,
                      color: Themes.darkPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}