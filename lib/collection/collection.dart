import 'package:dnmm/collection/collection_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../utills/themes.dart';

class Collection extends ConsumerStatefulWidget {
  final String label;

  const Collection({
    super.key,
    required this.label,
  });

  @override
  ConsumerState<Collection> createState() => _CollectionState();
}

class _CollectionState extends ConsumerState<Collection> {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? paymentMethod;
  bool showCashFields = false;
  bool showChequeFields = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Themes.defaultGreenColor.withOpacity(0.4),
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
            "Collection",
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              30.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.r),
                child: Container(
                  //height: 870.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40.r)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 50.r),
                              child: Text(
                                "Today :",
                                style: TextStyle(
                                  color: Themes.darkGreenHeader,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 70.r,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 5, child: textfield(text: formattedDate)),
                        ],
                      ),
                      30.verticalSpace,
                      textFormField(title: widget.label),
                      30.verticalSpace,
                      Customcontainer(text: "Payment Method"),
                      30.verticalSpace,
                      if (ref.watch(colleectionLogic).paymentMethod ==
                          "cash") ...[
                        textFormField(
                            title: 'Enter Amount',
                            keyboardType: TextInputType.phone),
                        30.verticalSpace,
                        textFormField(title: 'Remarks'),
                      ],
                      if (ref.watch(colleectionLogic).paymentMethod ==
                          "cheque") ...[
                        textFormField(
                            title: 'Cheque Clearance Date',
                            keyboardType: TextInputType.phone),
                        30.verticalSpace,
                        textFormField(title: 'Cheque Clearance Days'),
                        30.verticalSpace,
                        textFormField(
                            title: 'Cheque Number',
                            keyboardType: TextInputType.phone),
                        30.verticalSpace,
                        textFormField(title: 'Cheque Issuer Bank'),
                        30.verticalSpace,
                        textFormField(title: 'Cheque Deposit Bank'),
                        30.verticalSpace,
                        textFormField(
                            title: 'Enter Amount',
                            keyboardType: TextInputType.phone),
                        30.verticalSpace,
                        textFormField(title: 'Remarks'),
                      ],
                      30.verticalSpace,
                    ],
                  ),
                ),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget textfield({
    TextEditingController? controller1,
    String? text,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: 250.r,
        right: 60.r,
      ),
      child: Container(
        height: 130.r,
        width: 900.w,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Themes.darkPrimaryColor,
              width: 5.r,
            ),
          ),
          // borderRadius: BorderRadius.circular(.r),
        ),
        child: TextField(
          controller: controller1,
          decoration: InputDecoration(
            hintText: text,
            prefixText: "Today: ",
            prefixStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 53.r,
                color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget textFormField({
    String? title,
    String? hintxt,
    TextEditingController? controller,
    String? Function(String?)? validator,
    bool text = false,
    TextInputType? keyboardType,
    int? Length,
    MaxLengthEnforcement? Enforcement,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: Text(
              title ?? '',
              style: TextStyle(
                color: Themes.darkPrimaryColor,
                fontSize: 40.r,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.sp),
            decoration: BoxDecoration(
              color: Themes.iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            height: 150.r,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: TextFormField(
                    controller: controller,
                    validator: validator,
                    obscureText: text,
                    keyboardType: keyboardType,
                    maxLength: Length,
                    maxLengthEnforcement: Enforcement,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(35.r),
                      border: InputBorder.none,
                      hintText: hintxt,
                      counterText: "",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Customcontainer({String? text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
          child: Text(
            text ?? '',
            style: TextStyle(
              color: Themes.darkPrimaryColor,
              fontSize: 40.r,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showPaymentOptionsDialog(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.r, horizontal: 26.r),
            child: Container(
              height: 150.r,
              width: 1020.r,
              decoration: BoxDecoration(
                color: Themes.iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(45.r),
                child: Text(
                  paymentMethod ?? 'Select Payment Method',
                  style: TextStyle(
                    fontSize: 40.r,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  showPaymentOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Select Payment Method",
            style: TextStyle(
                fontSize: 70.r,
                fontWeight: FontWeight.bold,
                color: Themes.defaultGreenColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  "Cash",
                  style: TextStyle(
                    fontSize: 70.r,
                    fontWeight: FontWeight.bold,
                    color: Themes.darkPrimaryColor,
                  ),
                ),
                onTap: () {
                  ref.read(colleectionLogic).togglePaymentOptions("cash");

                  // setState(() {
                  //   paymentMethod = "Cash";
                  //   showChequeFields = false; // Show Cheque fields
                  //   showCashFields = true;
                  // });
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.money,
                  size: 100.r,
                  color: Themes.iconColor,
                ),
              ),
              ListTile(
                title: Text(
                  "Cheque",
                  style: TextStyle(
                    fontSize: 70.r,
                    fontWeight: FontWeight.bold,
                    color: Themes.darkPrimaryColor,
                  ),
                ),
                onTap: () {
                  ref.read(colleectionLogic).togglePaymentOptions("cheque");
                  // setState(() {
                  //   paymentMethod = "Cheque";
                  //   showChequeFields = true; // Show Cheque fields
                  //   showCashFields = false;
                  // });
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.monitor_heart_sharp,
                  size: 100.r,
                  color: Themes.iconColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}