import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../utills/themes.dart';
import 'Update_visit_logic.dart';

class UpdateVisitDistributor extends ConsumerStatefulWidget {
  const UpdateVisitDistributor({super.key});

  @override
  ConsumerState<UpdateVisitDistributor> createState() =>
      _UpdateVisitDistributorState();
}

class _UpdateVisitDistributorState
    extends ConsumerState<UpdateVisitDistributor> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
            backgroundColor: Themes.darkGreenHeader,
            centerTitle: true,
            actions: [
              customtextfield(text: "Search Here"),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.r,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5.r),
                          spreadRadius: 10.r,
                          blurRadius: 10.r,
                          offset: Offset(3, 2),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40.r)),
                    ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ref.watch(UpdateVisitLogic).Title.length,
                      itemBuilder: (context, index) {
                        return buildCategoryItemsTile(
                          title: ref.watch(UpdateVisitLogic).Title[index].name,
                          icon: ref.watch(UpdateVisitLogic).Title[index].icon,
                          //Ontap: ref.watch(UpdateVisitLogic).Title[index].
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildCategoryItemsTile({
    required IconData? icon,
    required String? title,
    // required Function? Ontap,
  }) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: InkWell(
          onTap: () {
            showDialogBox(title);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              80.horizontalSpace,
              Icon(
                icon,
                size: 100.r,
                color: Themes.darkPrimaryColor,
              ),
              100.horizontalSpace,
              Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 50.r,
                  color: Themes.darkPrimaryColor,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void showDialogBox(String? name) async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      String currentTime = DateFormat('jm').format(DateTime.now());
      String currentDate = DateFormat('yMMMMd').format(DateTime.now());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xffE7ECEF),
            title: Text("Update Location"),
            actions: [
              Text(
                'your current location is at $position with respect to $name on Today\'s date: $currentDate ,$currentTime',
                style: TextStyle(
                  fontSize: 40.r,
                  color: Themes.darkPrimaryColor,
                ),
              ),
              10.verticalSpace,
              customRowForTextformfeild(text: "Remark"),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CustomContainer('Cancel')),
                  20.horizontalSpace,
                  InkWell(onTap: () {}, child: CustomContainer('Save'))
                ],
              ),
              10.verticalSpace,
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(
                fontSize: 70.r,
                fontWeight: FontWeight.bold,
                color: Themes.darkGreenHeader,
              ),
            ),
            content: Text(
              e.toString(),
              style: TextStyle(
                fontSize: 40.r,
                color: Themes.darkPrimaryColor,
              ),
            ),
          );
        },
      );
    }
  }

  Widget customtextfield({
    bool editable = true,
    TextEditingController? controller1,
    String? text,
    TextInputType? keyboardType,
    Function? onUpdate,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 20.r),
      child: Container(
        width: 900.w,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 5.r,
            ),
          ),
        ),
        child: TextField(
          textAlign: TextAlign.left,
          keyboardType: keyboardType,
          controller: controller1,
          onChanged: (String? value) {
            onUpdate!(value);
          },
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            enabled: editable,
            hintText: text,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: const UnderlineInputBorder(),
          ),
        ),
      ),
    );
  }

  customRowForTextformfeild({
    required String text,
    TextEditingController? controller,
  }) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30.r),
          child: Text(
            text,
            style: TextStyle(fontSize: 40.r, color: Themes.primaryColor),
          ),
        ),
        12.horizontalSpace,
        Container(
          width: 550.w,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 5.r,
              ),
            ),
          ),
          child: TextField(
            textAlign: TextAlign.left,
            controller: controller,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              border: const UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget CustomContainer(String text) {
    return Container(
      height: 70.h,
      width: 350.w,
      decoration: BoxDecoration(
        color: Themes.darkGreenHeader,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 40.r, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}