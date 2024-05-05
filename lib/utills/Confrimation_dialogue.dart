import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final Color primaryColor;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    this.primaryColor = const Color(0xff6b1d1d),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.r,
      width: 950.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: Column(
        children: [
          20.verticalSpace,
          Text(
            title,
            style: TextStyle(
                color: primaryColor,
                fontSize: 50.r,
                fontWeight: FontWeight.w600),
          ),
          Divider(
            endIndent: 10,
            indent: 10,
            color: primaryColor,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 40.r),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                  height: 100.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.r,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Container(
                  height: 100.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                      child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.r,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              ),
            ],
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}