import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../utills/themes.dart';

final AddOutletLogic = ChangeNotifierProvider<addoutletLogic>((ref) {
  return addoutletLogic();
});

class addoutletLogic extends ChangeNotifier {
  File? image;
  File? primarycontactimage;
  String? selectedGroup;
  String? selectedType;
  String? selectedClass;
  String? selectGender;
  String? selectGendername;
  bool ischecked = false;
  bool isclicked = false;
  final ImagePicker imagePicker = ImagePicker();
  var outletName = TextEditingController();
  var contactNumber = TextEditingController();
  var selectRoute = TextEditingController();
  var selectArea = TextEditingController();
  var address = TextEditingController();
  var panNumber = TextEditingController();
  var selectDistributor = TextEditingController();
  var PrimaryContactName = TextEditingController();
  var Designation = TextEditingController();
  var primarycontacenumber = TextEditingController();
  List<Map<String, dynamic>> secContact = [];

  Map<String, dynamic> primaryContact = {
    "name": "",
    "number": "",
    "designation": ""
  };

  List<String> groups = [
    'Kathmandu',
    'bhaktapur',
    'Group 3',
  ];
  List<String> outletType = [
    'Bar',
    'Bhatti/Khaja ghar',
    'Casino',
    'Hotels & Lodge',
  ];
  List<String> outletClass = [
    'A',
    'B',
    'C',
  ];
  List<String> Genderoptions = [
    'Mr.',
    'Mrs.',
  ];
  List<String> Gender = [
    'Mr.',
    'Mrs.',
  ];

  setGroup(String? group) {
    selectedGroup = group;
    notifyListeners();
  }

  setGender(String? gender) {
    selectGender = gender;
    notifyListeners();
  }

  setGendername(String? gender) {
    selectGendername = gender;
    notifyListeners();
  }

  checkBox() {
    ischecked = !ischecked;
    notifyListeners();
  }

  setType(String? type) {
    selectedType = type;
    notifyListeners();
  }

  setClass(String? claass) {
    selectedClass = claass;
    notifyListeners();
  }

  outletNameValidator(String? msg) {
    if (msg == null || msg.length <= 3) {
      return "Please enter name";
    }
  }

  contactNumberValidator(String? msg) {
    if (msg == null || msg.length <= 10) {
      return "Please enter Phone number";
    }
    return null;
  }

  panValidator(String? msg) {
    if (msg == null || msg.length <= 10) {
      return "Please enter Phone number";
    }
    return null;
  }

  pickImage(ImageSource source) async {
    final XFile? pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      return pickedImage;
    }
    print('No image selected ');
    notifyListeners();
  }

  selectImages(ImageSource source) async {
    XFile img = await pickImage(source);
    image = await File(img.path);
    notifyListeners();
  }

  selectprimaricontacImages(ImageSource source) async {
    XFile imge = await pickImage(source);
    primarycontactimage = await File(imge.path);
    notifyListeners();
  }

  ShowContainer() {
    isclicked = !isclicked;
    notifyListeners();
  }

  addSecondary() {
    secContact.add({
      "name": TextEditingController(),
      "number": TextEditingController(),
      "designation": TextEditingController(),
    });
    notifyListeners();
  }

  hidePopupContainer(index) {
    if (secContact.isNotEmpty) {
      secContact.removeAt(index);
    }
    notifyListeners();
  }
}