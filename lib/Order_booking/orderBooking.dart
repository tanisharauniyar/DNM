// import 'package:dnmm/Order_booking/Order.dart';
// import 'package:dnmm/Order_booking/order_booking_logic.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import '../Custom_table/custom_table.dart';
// import '../Custom_table/datasource_orderbooking.dart';
// import '../utills/themes.dart';
//
// class OrderBooking extends ConsumerStatefulWidget {
//   const OrderBooking({super.key});
//
//   @override
//   ConsumerState<OrderBooking> createState() => _OrderBookingState();
// }
//
// class _OrderBookingState extends ConsumerState<OrderBooking>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//
//   void initState() {
//     super.initState();
//     // TODO: implement initState
//     // Future(() {
//     //   ref.read(orderbookingLogic).orderData();
//     // });
//
//     _tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Themes.lightGreen.withOpacity(0.1),
//           appBar: AppBar(
//             leading: InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.arrow_back_ios_new,
//                 size: 60.r,
//                 color: Colors.white,
//               ),
//             ),
//             automaticallyImplyLeading: false,
//             backgroundColor: Themes.darkGreenHeader,
//             centerTitle: true,
//             title: Text(
//               "Order Booking",
//               style: TextStyle(color: Colors.white, fontSize: 65.r),
//             ),
//             actions: [
//               InkWell(
//                 onTap: () {},
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Icon(
//                     Icons.save,
//                     size: 80.r,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           body: Column(
//             children: [
//               20.verticalSpace,
//               Container(
//                 child: DefaultTabController(
//                   length: ref.watch(orderbookingLogic).TabsTitle.length,
//                   child: TabBar(
//                     isScrollable: true,
//                     controller: _tabController,
//                     indicator: BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(
//                               color: Themes.darkGreenHeader, width: 10.r)),
//                     ),
//                     labelColor: Themes.darkGreenHeader,
//                     unselectedLabelColor: Colors.black,
//                     labelStyle: TextStyle(fontSize: 50.r),
//                     tabs: const [
//                       Tab(text: "GIN"),
//                       Tab(text: "VODKA"),
//                       Tab(text: "WHISKEY"),
//                       Tab(text: "SCOTCH"),
//                     ],
//                   ),
//                 ),
//               ),
//               120.verticalSpace,
//               Expanded(
//                 child: Container(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       Order(),
//                       Order(),
//                       Order(),
//                       Order(),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // CustomOrderTable() {
//   //   return CustomTable(
//   //     columnWidthMode: ColumnWidthMode.fill,
//   //     tableSummaryRows: const [],
//   //     showIndicator: false,
//   //     source: ref.watch(orderbookingLogic).orderDataSource ??
//   //         OrderBookingdata(data: []),
//   //     columns: [
//   //       GridColumn(
//   //         columnName: 'DESCRIPTION',
//   //         width: 450.r,
//   //         label: Center(
//   //           child: Center(
//   //             child: Text(
//   //               "DESCRIPTION ",
//   //               style: TextStyle(
//   //                   color: Colors.white,
//   //                   fontSize: 40.r,
//   //                   fontWeight: FontWeight.bold),
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //       GridColumn(
//   //         columnName: 'UNIT',
//   //         width: 250.r,
//   //         label: Center(
//   //           child: Text(
//   //             "UNIT",
//   //             style: TextStyle(
//   //                 color: Colors.white,
//   //                 fontSize: 40.r,
//   //                 fontWeight: FontWeight.bold),
//   //           ),
//   //         ),
//   //       ),
//   //       GridColumn(
//   //         columnName: 'QTY',
//   //         width: 250.r,
//   //         label: Center(
//   //           child: Text(
//   //             "QTY",
//   //             style: TextStyle(
//   //                 color: Colors.white,
//   //                 fontSize: 40.r,
//   //                 fontWeight: FontWeight.bold),
//   //           ),
//   //         ),
//   //       ),
//   //       GridColumn(
//   //         columnName: 'RATE',
//   //         width: 250.r,
//   //         label: Center(
//   //           child: Text(
//   //             "RATE",
//   //             style: TextStyle(
//   //                 color: Colors.white,
//   //                 fontSize: 40.r,
//   //                 fontWeight: FontWeight.bold),
//   //           ),
//   //         ),
//   //       ),
//   //       GridColumn(
//   //         columnName: 'AMT',
//   //         width: 250.r,
//   //         label: Center(
//   //           child: Text(
//   //             "AMT",
//   //             style: TextStyle(
//   //                 color: Colors.white,
//   //                 fontSize: 40.r,
//   //                 fontWeight: FontWeight.bold),
//   //           ),
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }
//   //
//   // CustomDropdown({
//   //   String? text,
//   //   String? Select,
//   //   required String? value,
//   //   required List<String> items,
//   //   required void Function(String?) onChanged,
//   // }) {
//   //   return Row(
//   //     children: [
//   //       Padding(
//   //         padding: EdgeInsets.only(left: 30.r),
//   //         child: Text(
//   //           text!,
//   //           style: TextStyle(
//   //             fontSize: 40.r,
//   //             color: Themes.primaryColor,
//   //           ),
//   //         ),
//   //       ),
//   //       30.horizontalSpace,
//   //       Expanded(
//   //         //flex: 16,
//   //         child: Padding(
//   //           padding: EdgeInsets.only(left: 30.r, right: 30.r, top: 20.r),
//   //           child: Container(
//   //             height: 130.r,
//   //             decoration: BoxDecoration(
//   //               border: Border.all(
//   //                 color: Themes.darkPrimaryColor,
//   //                 width: 5.r,
//   //               ),
//   //               borderRadius: BorderRadius.circular(20.r),
//   //             ),
//   //             child: Center(
//   //               child: Padding(
//   //                 padding: EdgeInsets.only(left: 50.w, right: 20.r),
//   //                 child: DropdownButtonHideUnderline(
//   //                   child: DropdownButtonFormField<String>(
//   //                     hint: Text(
//   //                       Select!,
//   //                       style: TextStyle(
//   //                         fontSize: 30.r,
//   //                       ),
//   //                     ),
//   //                     value: value,
//   //                     decoration: InputDecoration(border: InputBorder.none),
//   //                     items: items.map((val) {
//   //                       return DropdownMenuItem<String>(
//   //                         value: val.toString(),
//   //                         child: Text(
//   //                           val.toString(),
//   //                           style: TextStyle(
//   //                               fontSize: 40.r, fontWeight: FontWeight.w700),
//   //                         ),
//   //                       );
//   //                     }).toList(),
//   //                     onChanged: onChanged,
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //       30.verticalSpace,
//   //     ],
//   //   );
//   // }
// }