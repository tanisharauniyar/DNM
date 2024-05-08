import 'dart:io';
import 'package:dnmm/Custom_table/custom_table.dart';
import 'package:dnmm/Custom_table/dataSource.dart';
import 'package:dnmm/profile/profile_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../utills/themes.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({
    super.key,
  });

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    Future(() {
      ref.read(profileLogic).getReportData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("asdasdasdasdashjdvbashubduiasduib");

    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
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
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.white, fontSize: 65.r),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.r, horizontal: 5.r),
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18.r),
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 450.r,
                              clipBehavior: Clip.antiAlias,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Image.file(
                                ref.watch(profileLogic).image ?? File(""),
                                errorBuilder: (_, __, ___) {
                                  return Image.asset("assets/images/pas.jpg");
                                },
                              ),
                            ),
                            Positioned(
                              right: 10.r,
                              bottom: 10.r,
                              child: InkWell(
                                onTap: () {
                                  showDialogBox();
                                },
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 78.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                25.verticalSpace,
                Column(
                  children: [
                    Text(
                      "Contact no:",
                      style: TextStyle(
                          fontSize: 50.r, color: Colors.black.withOpacity(0.3)),
                    ),
                    Text(
                      "Attendance Time 2024-May-01,05:29 pm",
                      style: TextStyle(
                          fontSize: 50.r, color: Colors.black.withOpacity(0.3)),
                    )
                  ],
                ),
                35.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50.h,
                      width: 230.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: InkWell(
                        onTap: () {
                          ref.read(profileLogic).changeReport("Today");
                        },
                        child: Center(
                          child: Text(
                            "Today",
                            style: TextStyle(
                                fontSize: 50.r,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50.h,
                      width: 230.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: InkWell(
                        onTap: () {
                          ref.read(profileLogic).changeReport("MTD");
                        },
                        child: Center(
                          child: Text(
                            "MTD",
                            style: TextStyle(
                                fontSize: 50.r,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50.h,
                      width: 230.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: InkWell(
                        onTap: () {
                          ref.read(profileLogic).changeReport("YTD");
                        },
                        child: Center(
                          child: Text(
                            "YTD",
                            style: TextStyle(
                                fontSize: 50.r,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                30.verticalSpace,
                Expanded(
                  child: CustomTable(
                    columnWidthMode: ColumnWidthMode.fill,
                    tableSummaryRows: const [],
                    showIndicator: false,
                    source: ref.watch(profileLogic).reportDataSource ??
                        ProdVsSalesData(data: []),
                    stackedHeaders: [
                      StackedHeaderRow(
                        cells: <StackedHeaderCell>[
                          StackedHeaderCell(
                            columnNames: <String>[
                              'TodayTarget',
                              'TodayAchieved',
                              //'Sales'
                            ],
                            child: Center(
                              child: Text(
                                'Today',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 70.r,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          // StackedHeaderCell(
                          //   columnNames: <String>[
                          //     '',
                          //     '',
                          //   ],
                          //   child: const Center(
                          //     child: Text(
                          //       '',
                          //     ),
                          //   ),
                          // ),
                          StackedHeaderCell(
                            columnNames: <String>[
                              'MTDTarget',
                              'MTDAchieved',
                              //'MTD Sales'
                            ],
                            child: Center(
                              child: Text(
                                'MTD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 70.r,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          StackedHeaderCell(
                            columnNames: <String>[
                              'YTDTarget',
                              'YTDAchieved',
                              //'YTD Sales'
                            ],
                            child: Center(
                              child: Text(
                                'YTD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 70.r,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    columns: [
                      GridColumn(
                        columnName: 'Sales',
                        label: Center(
                          child: Center(
                            child: Text(
                              "Sales Target",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 60.r,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      // GridColumn(
                      //   columnName: 'MTD Sales',
                      //   label: Center(
                      //     child: Text(
                      //       "Sales Target",
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 60.r,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                      // GridColumn(
                      //   columnName: 'YTD Sales',
                      //   label: Center(
                      //     child: Text(
                      //       "Sales Target",
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 60.r,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                      GridColumn(
                        visible: ref.watch(profileLogic).selectedReportType ==
                            'Today',
                        columnName: 'TodayTarget',
                        label: Center(
                          child: Text(
                            "Target",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 60.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        visible: ref.watch(profileLogic).selectedReportType ==
                            'Today',
                        columnName: 'TodayAchieved',
                        label: Center(
                          child: Text(
                            "Achieved",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 60.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        visible:
                            ref.watch(profileLogic).selectedReportType == 'MTD',
                        columnName: 'MTDTarget',
                        label: Center(
                          child: Text(
                            "Target",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 60.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        visible:
                            ref.watch(profileLogic).selectedReportType == 'MTD',
                        columnName: 'MTDAchieved',
                        label: Center(
                          child: Text(
                            "Achieved",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 60.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        visible:
                            ref.watch(profileLogic).selectedReportType == 'YTD',
                        columnName: 'YTDTarget',
                        label: Center(
                          child: Text(
                            "Target",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 60.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        visible:
                            ref.watch(profileLogic).selectedReportType == 'YTD',
                        columnName: 'YTDAchieved',
                        label: Center(
                          child: Text(
                            "Achieved",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 60.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // buildHeaderDropdown() {
  //   return Container(
  //     padding: EdgeInsets.all(8.0),
  //     child: DropdownButton<String>(
  //       value: ref.watch(profileLogic).selectedReportType,
  //       onChanged: (String? newValue) {
  //         if (newValue != null) {
  //           ref.watch(profileLogic).changeReport(newValue);
  //         }
  //       },
  //       items: <String>['Today', 'MTD', 'YTD']
  //           .map<DropdownMenuItem<String>>((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }
  // StackedHeaderCell buildHeaderDropdown(
  //     BuildContext context, String reportType) {
  //   final selectedReportType = ref.watch(profileLogic).selectedReportType;
  //   return StackedHeaderCell(
  //     columnNames: <String>[
  //       if (selectedReportType == reportType)
  //         'DropDownColumn', // Add a new column name for the dropdown
  //       if (reportType == 'YTD') 'YTDTarget',
  //       if (reportType == 'TODAY') 'TodayTarget',
  //       if (reportType == 'MTD') 'MTDTarget',
  //     ],
  //     child: DropdownButton<String>(
  //       value: selectedReportType,
  //       onChanged: (String? newValue) {
  //         if (newValue != null) {
  //           ref.read(profileLogic).changeReport(newValue);
  //         }
  //       },
  //       items: <String>['TODAY', 'MTD', 'YTD']
  //           .map<DropdownMenuItem<String>>((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  showDialogBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Take a photo'),
                  onTap: () async {
                    await ref
                        .read(profileLogic)
                        .selectImages(ImageSource.camera);

                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: const Text('Choose from gallery'),
                  onTap: () async {
                    await ref
                        .read(profileLogic)
                        .selectImages(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}