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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
            backgroundColor: Themes.backgroundColour,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Themes.darkGreenHeader,
              title: Text(
                "Distirbution",
                style: TextStyle(color: Colors.white, fontSize: 55.r),
              ),
              actions: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.import_contacts_sharp,
                      size: 58.r,
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.r),
              child: InkWell(
                onTap: () {},
                child: GridView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.r),
                  physics: BouncingScrollPhysics(),
                  itemCount: ref.watch(dashboardLogic).dataList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 50.r,
                    mainAxisSpacing: 50.r,
                    childAspectRatio: 11 / 12,
                  ),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      child: Container(
        padding: EdgeInsets.all(30.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(45.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(3, 3),
                blurRadius: 5,
                spreadRadius: 1
                // inset: true,
                ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Icon(
              icon,
              size: 200.r,
              color: Colors.green,
            )),
            100.verticalSpace,
            Expanded(
              child: Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 40.r,
                  color: Colors.black,
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
    );
  }
}