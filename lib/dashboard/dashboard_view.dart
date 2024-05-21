import 'package:dnmm/Login/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utills/themes.dart';
import 'dashboard_logic.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  String? selectedMarketingRepresentative;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
            backgroundColor: Themes.defaultGreenColor.withOpacity(0.4),
            //backgroundColor: Themes.darkGreenHeader,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Themes.darkGreenHeader,
              centerTitle: true,
              title: Text(
                "Distirbution",
                style: TextStyle(color: Colors.white, fontSize: 65.r),
              ),
              actions: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.message_outlined,
                      size: 60.r,
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: InkWell(
                onTap: () {},
                child: GridView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.r),
                  physics: BouncingScrollPhysics(),
                  itemCount: ref.watch(dashboardLogic).dataList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.r,
                      mainAxisSpacing: 10.r,
                      childAspectRatio: 300 / 340),
                  itemBuilder: (BuildContext context, int index) {
                    return buildCategoryItemsTile(
                        data: ref.watch(dashboardLogic).dataList[index],
                        icon: ref.watch(dashboardLogic).dataList[index].icon,
                        title: ref.watch(dashboardLogic).dataList[index].name,
                        route:
                            ref.watch(dashboardLogic).dataList[index].route ??
                                MaterialPageRoute(
                                    builder: (context) => LoginView()));
                  },
                ),
              ),
            )),
      ),
    );
  }

  buildCategoryItemsTile({
    required CategoryModel data,
    required IconData? icon,
    required String? title,
    required route,
  }) {
    return InkWell(
      onTap: () {
        if (data.routeData.isNotEmpty) {
          showDialogBox(
            items: data.routeData,
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => data.route!),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Container(
          padding: EdgeInsets.all(40.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(45.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(4, 5),
                  blurRadius: 4,
                  spreadRadius: 1),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 200.r,
                    color: Themes.darkPrimaryColor,
                  ),
                ),
                140.verticalSpace,
                Expanded(
                  child: Text(
                    title ?? '',
                    style: TextStyle(
                      fontSize: 40.r,
                      color: Themes.darkPrimaryColor,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
    //);
  }

  showDialogBox({
    required List<Map> items,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          height: 790.r,
          width: 150.r,
          child: AlertDialog(
            title: Text(
              'Select Context',
              style: TextStyle(
                fontSize: 70.r,
                fontWeight: FontWeight.bold,
                color: Themes.darkGreenHeader,
              ),
            ),
            content: Container(
              height: 600.r,
              child: Column(
                children: [
                  for (var item in items)
                    Container(
                      width: 550.r,
                      height: 200.r,
                      child: ListTile(
                        leading: Icon(
                          item['icon'],
                          size: 80.r,
                          color: Themes.primaryColor,
                        ),
                        title: Text(
                          item['name'],
                          style: TextStyle(
                            fontSize: 70.r,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => item['route']));
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}