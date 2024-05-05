import 'dart:ui';

import 'package:dnmm/utills/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../Login/login_logic.dart';
import 'Confrimation_dialogue.dart';

class Widgets {
  static customAppbar(String title, BuildContext context,
      {List<Widget> actions = const [],
      bool showLeading = true,
      Orientation orientation = Orientation.portrait}) {
    // if (orientation == Orientation.portrait) {
    return AppBar(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title ?? "",
              style: TextStyle(color: Themes.primaryColor, fontSize: 55.r),
            ),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 5,
      leading: showLeading
          ? InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {},
              child: Icon(
                Icons.keyboard_arrow_left,
                size: 85.r,
                color: Themes.primaryColor,
              ))
          : null,
      actions: actions,
    );
    // }
    // else {
    //   return AppBar(
    //     title: Text(
    //       title ?? "",
    //       style: TextStyle(color: Themes.primaryColor, fontSize: 30.r),
    //     ),
    //     centerTitle: true,
    //     backgroundColor: Colors.white,
    //     elevation: 5,
    //     leading: showLeading
    //         ? InkWell(
    //             splashColor: Colors.transparent,
    //             highlightColor: Colors.transparent,
    //             hoverColor: Colors.transparent,
    //             onTap: () {
    //               AutoRouter.of(context).pop();
    //             },
    //             child: Icon(
    //               Icons.keyboard_arrow_left,
    //               size: 45.r,
    //               color: Themes.primaryColor,
    //             ))
    //         : null,
    //     actions: actions,
    //   );
    // }
  }

  static tabBar(List<Tab> tabs) {
    return TabBar(
        indicatorColor: Colors.transparent,
        unselectedLabelColor: Colors.black,
        labelStyle: Themes.heading2.apply(),
        tabs: tabs);
  }

  static textForm(BuildContext context, String label,
      TextEditingController controller, WidgetRef ref, FocusNode node,
      {Function? onChanged}) {
    return Container(
      height: 150.r,
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.r)),
      child: Center(
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          focusNode: node,
          style: Themes.heading2.copyWith(color: Colors.black),
          obscureText:
              label.contains('assword') ? ref.watch(loginLogic).obscure : false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid $label';
            }
            return null;
          },
          decoration: InputDecoration(
              focusedErrorBorder: InputBorder.none,
              suffixIcon: label == 'Password'
                  ? InkWell(
                      onTap: () {
                        ref.watch(loginLogic.notifier).togglePasswordView();
                      },
                      child: Icon(
                        Icons.remove_red_eye,
                        size: 50.r,
                        color: ref.watch(loginLogic).obscure
                            ? Themes.iconColor
                            : Colors.green,
                      ),
                    )
                  : null,
              enabledBorder: InputBorder.none,
              hintText: label,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }

  static customLoader() {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Center(
        child: Container(
          height: 150.h,
          width: 250.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Center(
            child: SizedBox(
              height: 180.r,
              width: 180.r,
              child: Stack(
                children: [
                  const LoadingIndicator(
                    indicatorType: Indicator.ballRotateChase,
                    strokeWidth: 2,
                    colors: [Themes.defaultGreenColor],
                  ),
                  Center(
                      child: Image.asset(
                    "assets/logo/neo_erp.png",
                    height: 110.r,
                    width: 110.r,
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}