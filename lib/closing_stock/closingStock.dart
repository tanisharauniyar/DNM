import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utills/TableForClosingStock.dart';
import '../utills/themes.dart';
import 'closingStockLogic.dart';

class ClosingStock extends ConsumerStatefulWidget {
  const ClosingStock({super.key});

  @override
  ConsumerState<ClosingStock> createState() => _ClosingStockState();
}

class _ClosingStockState extends ConsumerState<ClosingStock>
    with TickerProviderStateMixin {
  late TabController _tabController;

  void initState() {
    super.initState();
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            "Closing Stock",
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
        body: Column(
          children: [
            50.verticalSpace,
            Container(
              child: DefaultTabController(
                length: ref.watch(closingStockLogic).Title.length,
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Themes.darkGreenHeader,
                        width: 10.r,
                      ),
                    ),
                  ),
                  labelColor: Themes.darkGreenHeader,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 50.r),
                  tabs: const [
                    Tab(text: "GIN"),
                    Tab(text: "VODKA"),
                    Tab(text: "WHISKEY"),
                    Tab(text: "SCOTCH"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: const [
                  ClosingTable(),
                  ClosingTable(),
                  ClosingTable(),
                  ClosingTable(),
                ],
              ),
            ),
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
    );
  }

  customtextfield({
    bool editable = true,
    TextEditingController? controller1,
    String? text,
    TextInputType? keyboardType,
    required Function onUpdate,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Container(
        width: 670.w,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Themes.darkPrimaryColor,
              width: 5.r,
            ),
          ),
        ),
        child: TextField(
          textAlign: TextAlign.right,
          keyboardType: keyboardType,
          controller: controller1,
          onChanged: (String? value) {
            onUpdate(value);
          },
          decoration: InputDecoration(
            enabled: editable,
            hintText: text,
            border: const UnderlineInputBorder(),
          ),
        ),
      ),
    );
  }
}