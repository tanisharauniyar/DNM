import 'dart:io';
import 'package:dnmm/Add_outlet/select_area.dart';
import 'package:dnmm/Add_outlet/select_distributor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../utills/themes.dart';
import 'Select Route.dart';
import 'add_outlet_logic.dart';

class AddOutlet extends ConsumerStatefulWidget {
  const AddOutlet({super.key});

  @override
  ConsumerState<AddOutlet> createState() => _AddOutletState();
}

class _AddOutletState extends ConsumerState<AddOutlet> {
  var formKey = GlobalKey<FormState>();

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
            centerTitle: true,
            backgroundColor: Themes.darkGreenHeader,
            title: Text(
              "Add Outlet",
              style: TextStyle(color: Colors.white, fontSize: 65.r),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  25.verticalSpace,
                  if (ref.watch(AddOutletLogic).image != null)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Container(
                          height: 220.h,
                          width: 230.w,
                          color: Colors.black.withOpacity(0.1),
                          child: Image.file(
                            ref.watch(AddOutletLogic).image ?? File(""),
                            fit: BoxFit.cover,
                          )),
                    ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.r),
                    child: Container(
                      height: 900.h,
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
                      child: InkWell(
                        child: Column(
                          children: [
                            20.verticalSpace,
                            textFormField(
                              "Outlet Name",
                              icon: Icons.add_a_photo,
                              controller: ref.read(AddOutletLogic).outletName,
                              validator: (String? msg) {
                                return ref
                                    .read(AddOutletLogic)
                                    .outletNameValidator(msg);
                              },
                            ),
                            30.verticalSpace,
                            textFormField(
                              "Contact Number",
                              keyboardType: TextInputType.phone,
                              Length: 10,
                              controller:
                                  ref.read(AddOutletLogic).contactNumber,
                              Enforcement: MaxLengthEnforcement
                                  .truncateAfterCompositionEnds,
                              validator: (String? msg) {
                                return ref
                                    .read(AddOutletLogic)
                                    .contactNumberValidator(msg);
                              },
                            ),
                            30.verticalSpace,
                            textFormField(
                              "PAN ",
                              keyboardType: TextInputType.phone,
                              Length: 10,
                              controller: ref.read(AddOutletLogic).panNumber,
                              Enforcement: MaxLengthEnforcement
                                  .truncateAfterCompositionEnds,
                              validator: (String? msg) {
                                return ref
                                    .read(AddOutletLogic)
                                    .panValidator(msg);
                              },
                            ),
                            30.verticalSpace,
                            Customcontainer(
                              "Select Route ",
                              MaterialPageRoute(
                                builder: (context) => SelectRoute(),
                              ),
                            ),
                            30.verticalSpace,
                            Customcontainer(
                              "Select Area ",
                              MaterialPageRoute(
                                builder: (context) => SelectArea(),
                              ),
                            ),
                            30.verticalSpace,
                            textFormField(
                              "Address ",
                            ),
                            30.verticalSpace,
                            Customcontainer(
                              "Select Distributor ",
                              MaterialPageRoute(
                                builder: (context) => SelectDistributor(),
                              ),
                            ),
                            30.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.r),
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
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.r),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          CustomDropdown(
                            text: 'Outlet Group',
                            Select: "Select Group",
                            value: ref.watch(AddOutletLogic).selectedGroup,
                            items: ref.watch(AddOutletLogic).groups,
                            onChanged: (newValue) {
                              ref.read(AddOutletLogic).setGroup(newValue);
                            },
                          ),
                          30.verticalSpace,
                          customCheckBox(text: "Is Wholeseller ?"),
                          30.verticalSpace,
                          CustomDropdown(
                            text: 'Outlet Types',
                            Select: "Select Types",
                            value: ref.watch(AddOutletLogic).selectedType,
                            items: ref.watch(AddOutletLogic).outletType,
                            onChanged: (newValue) {
                              ref.read(AddOutletLogic).setType(newValue);
                            },
                          ),
                          30.verticalSpace,
                          CustomDropdown(
                            text: 'Outlet Class',
                            Select: "Select Class",
                            value: ref.watch(AddOutletLogic).selectedClass,
                            items: ref.watch(AddOutletLogic).outletClass,
                            onChanged: (newValue) {
                              ref.read(AddOutletLogic).setClass(newValue);
                            },
                          ),
                          30.verticalSpace,
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30.r),
                                child: Container(
                                  height: 70.h,
                                  width: 230.w,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  child: Center(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                        items: ref
                                            .watch(AddOutletLogic)
                                            .Genderoptions
                                            .map((val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text(
                                              val.toString(),
                                              style: TextStyle(
                                                  fontSize: 40.r,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValuee) {
                                          print(newValuee);
                                          ref
                                              .read(AddOutletLogic)
                                              .setGender(newValuee);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              150.horizontalSpace,
                              Expanded(
                                child: textfield(
                                  controller1: ref
                                      .read(AddOutletLogic)
                                      .PrimaryContactName,
                                  text: "primary contact name ",
                                  iconn: Icons.add_a_photo,
                                ),
                              ),
                            ],
                          ),
                          30.verticalSpace,
                          if (ref.watch(AddOutletLogic).primarycontactimage !=
                              null)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 390.w),
                              child: Container(
                                  height: 240.h,
                                  width: 230.w,
                                  color: Colors.black.withOpacity(0.1),
                                  child: Image.file(
                                    ref
                                            .watch(AddOutletLogic)
                                            .primarycontactimage ??
                                        File(""),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          30.verticalSpace,
                          textfield(
                            controller1: ref.read(AddOutletLogic).Designation,
                            text: "Designation",
                          ),
                          30.verticalSpace,
                          textfield(
                            controller1:
                                ref.read(AddOutletLogic).primarycontacenumber,
                            text: "Primary Contact Number",
                            keyboardType: TextInputType.phone,
                          ),
                          50.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ref.watch(AddOutletLogic).secContact.length,
                    itemBuilder: (context, index) {
                      return showPopupContainer(index);
                    },
                  ),
                  30.verticalSpace,
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 80.h,
                      width: 900.w,
                      decoration: BoxDecoration(
                        color: Themes.darkGreenHeader,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 48.r,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ref.watch(AddOutletLogic).addSecondary();
              // showPopupContainer();
              //ref.watch(AddOutletLogic).primaryContact;
            },
            backgroundColor: Themes.defaultGreenColor,
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }

  Widget Customcontainer(
    String? text,
    PageRoute? route,
  ) {
    return InkWell(
      onTap: () {
        if (route != null) {
          Navigator.of(context).push(route!);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.r, horizontal: 26.r),
        child: Container(
          height: 140.r,
          width: 1020.r,
          decoration: BoxDecoration(
            color: Themes.iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(30.r),
            child: Text(
              text!,
              style: TextStyle(
                fontSize: 40.r,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield(
      {TextEditingController? controller1,
      String? text,
      IconData? iconn,
      TextInputType? keyboardType,
      Function(String?)? Onchanged}) {
    return Container(
      height: 150.r,
      width: 2000.w,
      child: Padding(
        padding: EdgeInsets.all(25.r),
        child: TextField(
          keyboardType: keyboardType,
          controller: controller1,
          onChanged: Onchanged,
          decoration: InputDecoration(
            hintText: text,
            suffixIcon: iconn != null
                ? InkWell(
                    onTap: () {
                      showDialogBox(
                          ontap: ref
                              .read(AddOutletLogic)
                              .selectprimaricontacImages(ImageSource.camera),
                          ontapp: ref
                              .read(AddOutletLogic)
                              .selectprimaricontacImages(ImageSource.gallery));
                    },
                    child: Icon(
                      iconn,
                      color: Themes.darkGreenHeader,
                      size: 58.r,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget textFormField(String hintxt,
      {TextEditingController? controller,
      String? Function(String?)? validator,
      bool text = false,
      TextInputType? keyboardType,
      int? Length,
      MaxLengthEnforcement? Enforcement,
      IconData? icon,
      PageRoute? route}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.r),
      child: Container(
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
              onTap: () {
                if (route != null) {
                  Navigator.of(context).push(route!);
                }
              },
              child: TextFormField(
                controller: controller,
                validator: validator,
                obscureText: text,
                keyboardType: keyboardType,
                maxLength: Length,
                maxLengthEnforcement: Enforcement,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 26.r, top: 20.r, bottom: 30.r),
                  border: InputBorder.none,
                  hintText: hintxt,
                  counterText: "",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  suffixIcon: icon != null
                      ? InkWell(
                          onTap: () {
                            showDialogBox(
                                ontap: ref
                                    .read(AddOutletLogic)
                                    .selectImages(ImageSource.camera),
                                ontapp: ref
                                    .read(AddOutletLogic)
                                    .selectImages(ImageSource.gallery));
                          },
                          child: Icon(
                            icon,
                            color: Themes.darkGreenHeader,
                            size: 75.r,
                          ),
                        )
                      : null,
                ),
              ),
            ),
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
            ref.watch(AddOutletLogic).checkBox();
          },
          child: Container(
            height: 70.r,
            width: 70.r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  (Radius.circular(20.r)),
                ),
                border: Border.all(
                  color: ref.watch(AddOutletLogic).ischecked
                      ? Themes.darkGreenHeader
                      : Themes.iconColor.withOpacity(0.3),
                  width: 5.r,
                ),
                color: ref.watch(AddOutletLogic).ischecked
                    ? Themes.darkGreenHeader
                    : Colors.white),
            child: Icon(
              Icons.check,
              size: 60.r,
              color: ref.watch(AddOutletLogic).ischecked
                  ? Colors.white
                  : Colors.white,
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
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30.r),
          child: Text(
            text!,
            style: TextStyle(
              fontSize: 40.r,
              color: Themes.primaryColor,
            ),
          ),
        ),
        30.horizontalSpace,
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 70.r, right: 30.r, top: 20.r),
            child: Container(
              height: 130.r,
              decoration: BoxDecoration(
                color: Themes.iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 20.r),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      hint: Text(
                        Select!,
                        style: TextStyle(
                          fontSize: 30.r,
                        ),
                      ),
                      value: value,
                      decoration: InputDecoration(border: InputBorder.none),
                      items: items.map((val) {
                        print(val);
                        return DropdownMenuItem<String>(
                          value: val.toString(),
                          child: Text(
                            val.toString(),
                            style: TextStyle(
                                fontSize: 40.r, fontWeight: FontWeight.w700),
                          ),
                        );
                      }).toList(),
                      onChanged: onChanged,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        30.verticalSpace,
      ],
    );
  }

  showDialogBox({required Function ontap, required Function ontapp}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Choose an option',
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
                  leading: Icon(
                    Icons.camera,
                    size: 100.r,
                    color: Themes.primaryColor,
                  ),
                  title: Text(
                    'Distributor',
                    style: TextStyle(
                      fontSize: 70.r,
                      fontWeight: FontWeight.bold,
                      color: Themes.darkPrimaryColor,
                    ),
                  ),
                  onTap: () async {
                    await ontap;

                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    size: 100.r,
                    color: Themes.primaryColor,
                  ),
                  title: Text(
                    'Outlet',
                    style: TextStyle(
                      fontSize: 70.r,
                      fontWeight: FontWeight.bold,
                      color: Themes.darkPrimaryColor,
                    ),
                  ),
                  onTap: () async {
                    await ontapp;
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

  Widget showPopupContainer(index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.r),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.sp),
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
            borderRadius: BorderRadius.circular(20.r),
          ),
          height: 700.r,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 800.r, top: 30.r),
                child: InkWell(
                  onTap: () {
                    ref.watch(AddOutletLogic).hidePopupContainer(index);
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 80.r,
                    color: Colors.red,
                  ),
                ),
              ),
              20.verticalSpace,
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.r),
                    child: Container(
                      height: 70.h,
                      width: 230.w,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            items: ref.watch(AddOutletLogic).Gender.map((val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val.toString(),
                                  style: TextStyle(
                                      fontSize: 40.r,
                                      fontWeight: FontWeight.w700),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValuee) {
                              print(newValuee);
                              ref.read(AddOutletLogic).setGendername(newValuee);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  100.horizontalSpace,
                  Expanded(
                    child: textfield(
                      controller1: ref.read(AddOutletLogic).secContact[index]
                          ['name'],
                      text: "Secondary contact name ",
                    ),
                  ),
                ],
              ),
              textfield(
                controller1: ref.read(AddOutletLogic).secContact[index]
                    ['designation'],
                text: "Designation ",
              ),
              textfield(
                controller1: ref.read(AddOutletLogic).secContact[index]
                    ['number'],
                text: "Secondary contact number ",
              ),
              20.verticalSpace,
            ],
          )),
    );
  }
}