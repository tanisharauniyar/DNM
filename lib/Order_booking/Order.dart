import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Calibrate_location/outlet.dart';
import '../utills/themes.dart';
import 'order_booking_logic.dart';

class Order extends ConsumerStatefulWidget {
  const Order({
    super.key,
  });

  @override
  ConsumerState<Order> createState() => _OrderBookingState();
}

class _OrderBookingState extends ConsumerState<Order>
    with TickerProviderStateMixin {
  late TabController _tabController;

  void initState() {
    super.initState();
    // TODO: implement initState

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Themes.defaultGreenColor.withOpacity(0.1),
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 60.r,
                color: Colors.white,
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Themes.darkGreenHeader,
            centerTitle: true,
            title: Text(
              "Order Booking",
              style: TextStyle(color: Colors.white, fontSize: 65.r),
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.save,
                    size: 80.r,
                  ),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              50.verticalSpace,
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 70.r),
                    child: Text(
                      //widget.text,
                      "Remarks :",
                      style: TextStyle(
                        color: Themes.darkGreenHeader,
                        fontWeight: FontWeight.bold,
                        fontSize: 70.r,
                      ),
                    ),
                  ),
                  20.horizontalSpace,
                  customtextfield(
                    onUpdate: () {},
                  )
                ],
              ),
              100.verticalSpace,
              Container(
                child: DefaultTabController(
                  length: ref.watch(orderbookingLogic).TabsTitle.length,
                  child: TabBar(
                    // isScrollable: false,
                    controller: _tabController,
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Themes.darkGreenHeader,
                          width: 10.r,
                        ),
                      ),
                    ),
                    labelColor: Themes.darkGreenHeader,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(fontSize: 50.r),
                    tabs: const [
                      Tab(text: "GIN"),
                      Tab(text: "VODKA"),
                      Tab(text: "WHISKEY"),
                      Tab(text: "SCOTCH"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: const [
                      Outlet(),
                      Outlet(),
                      Outlet(),
                      Outlet(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  CustomTable() {
    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 970.h,
        child: Column(
          children: [
            50.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              height: 170.r,
              color: Themes.defaultGreenColor,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Description",
                      style: Themes.tableHeadPortrait(Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Unit",
                        style: Themes.tableHeadPortrait(Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Quantity",
                        style: Themes.tableHeadPortrait(Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Rate",
                        style: Themes.tableHeadPortrait(Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Amount",
                        style: Themes.tableHeadPortrait(Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: ref.watch(orderbookingLogic).listOrder.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    height: 180.r,
                    //width: 200 * 5.r,
                    color: index % 2 == 0
                        ? Themes.lightGreen.withOpacity(0.2)
                        : Themes.darkGreenHeader.withOpacity(0.2),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              showDialogBox();
                            },
                            child: Text(
                              ref
                                      .watch(orderbookingLogic)
                                      .listOrder[index]['name']
                                      .toString() ??
                                  '',
                              style: Themes.tableData.copyWith(
                                fontSize: 40.r,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 71.r),
                            child: CustomDropdown(
                              Select: 'Unit',
                              value: ref
                                  .watch(orderbookingLogic)
                                  .listOrder[index]['selected_unit']
                                  .toString(),
                              items:
                                  ref.watch(orderbookingLogic).listOrder[index]
                                      ['available_units'] as List<String>,
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  ref
                                      .read(orderbookingLogic)
                                      .setGroup(index, newValue);
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: customtextfield(
                            text: ref
                                    .watch(orderbookingLogic)
                                    .listOrder[index]['quantity']
                                    .toString() ??
                                '',
                            keyboardType: TextInputType.phone,
                            onUpdate: (qty) {
                              ref
                                  .read(orderbookingLogic)
                                  .setQtyAndAmt(index, qty);
                            },
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: customtextfield(
                              text: ref
                                      .watch(orderbookingLogic)
                                      .listOrder[index]['active rate']
                                      .toString() ??
                                  '',
                              keyboardType: TextInputType.phone,
                              onUpdate: (qty) {
                                ref
                                    .read(orderbookingLogic)
                                    .setQtyAndAmt(index, qty);
                              },
                              editable: false),
                        ),
                        Expanded(
                          flex: 2,
                          child: customtextfield(
                              text: ref
                                      .watch(orderbookingLogic)
                                      .listOrder[index]['amt']
                                      .toString() ??
                                  '',
                              keyboardType: TextInputType.phone,
                              onUpdate: (qty) {
                                ref
                                    .read(orderbookingLogic)
                                    .setQtyAndAmt(index, qty);
                              },
                              editable: false),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            20.verticalSpace,
          ],
        ),
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
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        hint: Text(
          Select ?? "",
          style: TextStyle(
            fontSize: 40.r,
          ),
        ),
        value: value,
        onChanged: onChanged,
        decoration: const InputDecoration(border: InputBorder.none),
        items: items.map((val) {
          return DropdownMenuItem<String>(
            value: val.toString(),
            child: Text(
              val.toString(),
              style: TextStyle(fontSize: 40.r, fontWeight: FontWeight.w700),
            ),
          );
        }).toList(),
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
      child: Container(
        width: 670.w,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Themes.darkPrimaryColor,
              width: 5.r,
            ),
          ),
        ),
        child: TextField(
          textAlign: TextAlign.right,
          keyboardType: keyboardType,
          controller: controller1,
          onChanged: (String? value) {
            onUpdate(value);
          },
          decoration: InputDecoration(
            enabled: editable,
            hintText: text,
            border: const UnderlineInputBorder(),
          ),
        ),
      ),
    );
  }

  customCheckBox({
    String? text,
  }) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30.r),
          child: Text(
            text!,
            style: TextStyle(fontSize: 40.r, color: Themes.primaryColor),
          ),
        ),
        32.horizontalSpace,
        InkWell(
          onTap: () {
            ref.watch(orderbookingLogic).checkBox();
          },
          child: Container(
            height: 70.r,
            width: 70.r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  (Radius.circular(20.r)),
                ),
                border: Border.all(
                  color: ref.watch(orderbookingLogic).ischecked
                      ? Themes.darkGreenHeader
                      : Themes.darkPrimaryColor,
                  width: 5.r,
                ),
                color: ref.watch(orderbookingLogic).ischecked
                    ? Themes.darkGreenHeader
                    : Themes.lightGreen.withOpacity(0.1)),
            child: Icon(Icons.check,
                size: 60.r,
                color: ref.watch(orderbookingLogic).ischecked
                    ? Colors.white
                    : Colors.white),
          ),
        ),
      ],
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