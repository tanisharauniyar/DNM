// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../utills/themes.dart';
//
// final colleectionLogic = ChangeNotifierProvider<CollectionLogic>((ref) {
//   return CollectionLogic();
// });
//
// class CollectionLogic extends ChangeNotifier {
//
//   showPaymentOptionsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             "Select Payment Method",
//             style: TextStyle(
//               fontSize: 70.r,
//               fontWeight: FontWeight.bold,
//               color: Themes.darkGreenHeader,
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: Text(
//                   "Cash",
//                   style: TextStyle(
//                     fontSize: 70.r,
//                     fontWeight: FontWeight.bold,
//                     color: Themes.darkPrimaryColor,
//                   ),
//                 ),
//                 onTap: () {
//                   setState(() {
//                     paymentMethod = "Cash";
//                     showChequeFields = false; // Show Cheque fields
//                     showCashFields = true;
//                   });
//                   Navigator.pop(context);
//                 },
//                 leading: Icon(
//                   Icons.money,
//                   size: 100.r,
//                   color: Themes.primaryColor,
//                 ),
//               ),
//               ListTile(
//                 title: Text(
//                   "Cheque",
//                   style: TextStyle(
//                     fontSize: 70.r,
//                     fontWeight: FontWeight.bold,
//                     color: Themes.darkPrimaryColor,
//                   ),
//                 ),
//                 onTap: () {
//                   setState(() {
//                     paymentMethod = "Cheque";
//                     showChequeFields = true; // Show Cheque fields
//                     showCashFields = false;
//                   });
//                   Navigator.pop(context);
//                 },
//                 leading: Icon(
//                   Icons.monitor_heart_sharp,
//                   size: 100.r,
//                   color: Themes.primaryColor,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }