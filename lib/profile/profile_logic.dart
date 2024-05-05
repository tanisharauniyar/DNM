import 'dart:io';
import 'dart:typed_data';
import 'package:dnmm/Custom_table/dataSource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final profileLogic = ChangeNotifierProvider<ProfileLogic>((ref) {
  return ProfileLogic();
});

class ProfileLogic extends ChangeNotifier {
  List<Report> report = <Report>[];
  ProdVsSalesData? reportDataSource;
  String selectedReportType = 'Today';
  final ImagePicker _imagePicker = ImagePicker();
  File? image;
  Uint8List? images;
  bool isSelected = true;

  setGrouping() {
    reportDataSource
        ?.addColumnGroup(ColumnGroup(name: 'Sales', sortGroupRows: true));
  }

  /// from the datasoure
  getReportData() {
    report = [
      Report("QTY wise", 100, 20, 1000, 200, 10000, 2000),
      Report("Amount wise", 100, 10, 1000, 200, 10000, 2000),
      Report("Apple", 100, 20, 1000, 200, 10000, 2000),
      Report("Samsung", 100, 1, 1000, 200, 10000, 2000),
      Report("Asus", 100, 20, 1000, 200, 10000, 2000),
      Report("bhaktapur", 100, 6, 1000, 200, 10000, 2000),
      Report("lalitpur", 100, 3, 1000, 200, 10000, 2000),
      Report("kathmandu", 100, 7, 1000, 200, 10000, 2000),
      Report("sriya", 100, 20, 1000, 200, 10000, 2000),
      Report("kritika", 100, 20, 1000, 200, 10000, 2000),
      Report("lalbahadur", 100, 20, 1000, 200, 10000, 2000),
      Report("plan wise ", 100, 12, 1000, 200, 10000, 2000),
    ];
    reportDataSource = ProdVsSalesData(data: report);
    setGrouping();
    notifyListeners();
  }

  changeReport(String reportType) {
    selectedReportType = reportType;
    notifyListeners();
  }

  selectedContanier() {
    isSelected = !isSelected;
  }

  pickImage(ImageSource source) async {
    final XFile? pickedImage = await _imagePicker.pickImage(source: source);
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
}