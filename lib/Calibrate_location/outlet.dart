import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../Order_booking/order_booking_logic.dart';
import '../utills/themes.dart';

class Outlet extends ConsumerStatefulWidget {
  const Outlet({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<Outlet> createState() => _OutletState();
}

class _OutletState extends ConsumerState<Outlet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 25.h),
        child: Container(
          //height: 600.h,
          child: HorizontalDataTable(
            leftHandSideColumnWidth: 400.r,
            rightHandSideColumnWidth: 910.h,
            isFixedHeader: true,
            headerWidgets: TableTitleName(),
            leftSideItemBuilder: FixedColumn,
            rightSideItemBuilder: ScrollableColumn,
            itemCount: ref.watch(orderbookingLogic).listOrder.length,
            rowSeparatorWidget: const Divider(
              color: Colors.black,
              height: 0.00,
              thickness: 1.0,
            ),
            // leftHandSideColBackgroundColor:
            //     Themes.darkGreenHeader.withOpacity(0.3),
            // rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
          ),
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
        'Quantity',
        290.r,
      ),
      TableHeaderName(
        'Rate',
        300.r,
      ),
      TableHeaderName(
        'Amount',
        660.r,
      ),
    ];
  }

  Widget TableHeaderName(String label, double width) {
    return Container(
      width: width,
      height: 150.h,
      decoration:
          BoxDecoration(color: Themes.defaultGreenColor), // Adjusted height
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
      height: 150.h,
      color: getRowColor(0), // Adjusted height
      child: Center(
        child: Text(
          ref.watch(orderbookingLogic).listOrder[index]['name'].toString() ??
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
    return Row(
      children: <Widget>[
        Container(
          width: 310.r,
          height: 150.h,
          color: getRowColor(1), // Adjusted height
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 71.r),
            child: CustomDropdown(
              Select: 'Unit',
              value: ref
                  .watch(orderbookingLogic)
                  .listOrder[index]['selected_unit']
                  .toString(),
              items: ref.watch(orderbookingLogic).listOrder[index]
                  ['available_units'] as List<String>,
              onChanged: (newValue) {
                if (newValue != null) {
                  ref.read(orderbookingLogic).setGroup(index, newValue);
                }
              },
            ),
          ),
        ),
        Container(
          width: 250.r,
          height: 150.h, // Adjusted height
          color: getRowColor(2),
          child: customtextfield(
            text: ref
                    .watch(orderbookingLogic)
                    .listOrder[index]['quantity']
                    .toString() ??
                '',
            keyboardType: TextInputType.phone,
            onUpdate: (qty) {
              ref.read(orderbookingLogic).setQtyAndAmt(index, qty);
            },
          ),
        ),
        Container(
          width: 290.r,
          height: 150.h, // Adjusted height
          color: getRowColor(3),
          child: customtextfield(
            text: ref
                    .watch(orderbookingLogic)
                    .listOrder[index]['active rate']
                    .toString() ??
                '',
            keyboardType: TextInputType.phone,
            onUpdate: (qty) {
              ref.read(orderbookingLogic).setQtyAndAmt(index, qty);
            },
            editable: false,
          ),
        ),
        Container(
          color: getRowColor(4),
          width: 620.r,
          height: 150.h, // Adjusted height
          child: customtextfield(
            text: ref
                    .watch(orderbookingLogic)
                    .listOrder[index]['amt']
                    .toString() ??
                '',
            keyboardType: TextInputType.phone,
            onUpdate: (qty) {
              ref.read(orderbookingLogic).setQtyAndAmt(index, qty);
            },
            editable: false,
          ),
        ),
      ],
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
}