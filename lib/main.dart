import 'dart:math';
import 'package:dnmm/Custom_table/dataSource.dart';
import 'package:dnmm/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'Login/login_view.dart';
import 'dashboard/dashboard_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  double isTablet(MediaQueryData query) {
    var size = query.size;
    var diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));

    print('size: ${size.width}x${size.height}\n'
        'pixelRatio: ${query.devicePixelRatio}\n'
        'pixels: ${size.width * query.devicePixelRatio}x${size.height * query.devicePixelRatio}\n'
        'diagonal: $diagonal');

    var isTablet = diagonal > 1100.0;
    print(isTablet);
    return isTablet ? 1.5 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        1080 * isTablet(MediaQuery.of(context)),
        1366 * isTablet(MediaQuery.of(context)),
      ),
      child: ProviderScope(
        child: MaterialApp(
          //color: Colors.white,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            //primarySwatch: Colors.green,
            useMaterial3: false,
          ),
          home: LoginView(),
        ),
      ),
    );
  }
}