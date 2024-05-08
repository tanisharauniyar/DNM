import 'package:dnmm/Calibrate_location/calibrate_location.dart';
import 'package:dnmm/Calibrate_location/distributor.dart';
import 'package:dnmm/Calibrate_location/outlet.dart';
import 'package:dnmm/Login/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utills/themes.dart';
import 'dashboard_logic.dart';
import 'dashboard_logic.dart';
import 'dashboard_logic.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
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

  // getImages(String title) {
  //   switch (title.toLowerCase()) {
  //     case "Profile":
  //       return FaIcon(FontAwesomeIcons.peopleRoof);
  //     case "Visit Plan":
  //       return FaIcon(FontAwesomeIcons.peopleRoof);
  //     case "Add outlet":
  //       return FaIcon(Icons.sports_cricket);
  //     case "Order Booking":
  //       return FaIcon(FontAwesomeIcons.bicycle);
  //     case "Sales Return":
  //       return FaIcon(FontAwesomeIcons.volleyball);
  //     case "UPdate Market Status":
  //       return FaIcon(FontAwesomeIcons.tshirt);
  //     case "A/C  Statement":
  //       return FaIcon(FontAwesomeIcons.tshirt);
  //     case "closing Stock":
  //       return FaIcon(FontAwesomeIcons.tshirt);
  //   }
  // }

  buildCategoryItemsTile({
    required IconData? icon,
    required String? title,
    required route,
  }) {
    return InkWell(
      onTap: () {
        if (ref.watch(dashboardLogic).titlesToShowDialog.contains(title)) {
          showDialogBox(
            ontap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MapScreen()));
            },
            ontapp: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Outlet()));
            },
          );
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => route));
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
  }

  showDialogBox({required Function ontap, required Function ontapp}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Context'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                    leading: const Icon(Icons.dangerous_outlined),
                    title: const Text('Distributor'),
                    onTap: () {
                      ontap();
                    }),
                ListTile(
                    leading: const Icon(Icons.outbond_outlined),
                    title: const Text('OutLet'),
                    onTap: () {
                      ontapp();
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}