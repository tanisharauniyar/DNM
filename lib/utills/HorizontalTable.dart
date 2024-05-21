import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../Order_booking/order_booking_logic.dart';
import 'themes.dart';

class HorizontaleDataTable extends ConsumerStatefulWidget {
  const HorizontaleDataTable({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HorizontaleDataTable> createState() => _OutletState();
}

class _OutletState extends ConsumerState<HorizontaleDataTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      //height: 790.h,
      color: Colors.transparent,
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 400.r,
        rightHandSideColumnWidth: 910.h,
        isFixedHeader: true,
        headerWidgets: TableTitleName(),
        leftSideItemBuilder: FixedColumn,
        rightSideItemBuilder: ScrollableColumn,
        itemCount: ref.watch(orderbookingLogic).listOrder.length,
        rowSeparatorWidget: const Divider(
          color: Colors.grey,
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
      height: 120.h,
      decoration: const BoxDecoration(
          color: Themes.defaultGreenColor), // Adjusted height
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
    return InkWell(
      onTap: () {
        showDialogBox();
      },
      child: Container(
        width: 450.r,
        height: 100.h,
        color: getRowColor(index),
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
      ),
    );
  }

  Widget ScrollableColumn(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 310.r,
          height: 100.h,
          color: getRowColor(index),
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
          height: 100.h,
          color: getRowColor(index),
          child: Center(
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
        ),
        Container(
          width: 290.r,
          height: 100.h,
          color: getRowColor(index),
          child: Center(
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
              editable: true,
            ),
          ),
        ),
        Container(
          color: getRowColor(index),
          width: 620.r,
          height: 100.h,
          child: Center(
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