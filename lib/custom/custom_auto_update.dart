// import 'dart:convert';
// import 'dart:io';
// import 'package:google_play_scraper/models.dart';
// import 'package:http/http.dart' as http;
// import 'package:app_version_update/app_version_update.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:google_play_scraper/google_play_scraper.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart';
//
// import '../main.dart';
// import '../utils/colors.dart';
// import '../utils/const.dart';
// import '../utils/utils.dart';
// import 'bold_text_widget.dart';
// import 'medium_text_widget.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' show parse;
//
// class CustomAutoUpdate {
//   void verifyVersion(BuildContext context) async {
//     try {
//       getAppInfo();
//       fetchAppDetails();
//       await AppVersionUpdate.checkForUpdates(
//         playStoreId: 'com.gnums.gnums',
//         // appleId: '6449359902',
//       ).then((result) async {
//         if (result.canUpdate!) {
//           await showModalBottomSheet<void>(
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//             ),
//             context: context,
//             builder: (BuildContext context) {
//               return SafeArea(
//                 child: Container(
//                   height: 40.h,
//                   // color: Colors.amber,
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       // mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Expanded(
//                             child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 15,
//                                       backgroundColor: Colors.white,
//                                       child: Platform.isAndroid
//                                           ? const ClipOval(
//                                               child: Image(
//                                               image: AssetImage(
//                                                   "assets/images/google play.png"),
//                                               width: 100,
//                                             ))
//                                           : const ClipOval(
//                                               child: Image(
//                                               image: AssetImage(
//                                                   "assets/images/app_store_icon.png"),
//                                               width: 80,
//                                             )),
//                                     ),
//                                     SizedBox(
//                                       width: 1.w,
//                                     ),
//                                     BoldTextWidget(
//                                       title: Platform.isAndroid
//                                           ? 'Google Play'
//                                           : "App Store",
//                                       fontsize: 12.sp,
//                                     ),
//                                   ],
//                                 ),
//                                 InkWell(
//                                     onTap: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: const Icon(Icons.close))
//                               ],
//                             ),
//                             SizedBox(
//                               height: 2.h,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 5.w),
//                               child: BoldTextWidget(
//                                   title: 'Update available', fontsize: 14.sp),
//                             ),
//                             SizedBox(
//                               height: 1.h,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 5.w),
//                               child: MediumTextWidget(
//                                 align: TextAlign.justify,
//                                 title:
//                                     "GNUMS For Students/Parents recommends that you update to the latest version. You can keep using this app while downloading the update.",
//                                 fontsize: 11.sp,
//                               ),
//                             ),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 40,
//                                   backgroundColor: Colors.white,
//                                   child: ClipOval(
//                                       child: Image(
//                                     image: AssetImage(getImagePath(preferenceMan
//                                         .getInstituteCode()
//                                         .toString())),
//                                     width: 100,
//                                   )),
//                                 ),
//                                 SizedBox(
//                                   width: 1.w,
//                                 ),
//                                 Flexible(
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 2.5.h,
//                                       ),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           BoldTextWidget(
//                                             title: "GNUMS For Students/Parents",
//                                             fontsize: 13.sp,
//                                           ),
//                                           Row(
//                                             children: [
//                                               MediumTextWidget(
//                                                 title: '3.0',
//                                                 fontsize: 12.sp,
//                                               ),
//                                               Icon(Icons.star, size: 12.sp),
//                                               SizedBox(
//                                                 width: 3.w,
//                                               ),
//                                               MediumTextWidget(
//                                                 title: '23 MB',
//                                                 fontsize: 12.sp,
//                                               ),
//                                               SizedBox(
//                                                 width: 3.w,
//                                               ),
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color: Colors
//                                                         .black, // Set border color
//                                                   ), // Set border width
//                                                 ),
//                                                 child: Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 1.w),
//                                                   child: MediumTextWidget(
//                                                       title: '3+',
//                                                       fontsize: 12.sp),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 3.w,
//                                               ),
//                                               MediumTextWidget(
//                                                 title: 'Rated for 3+',
//                                                 fontsize: 12.sp,
//                                               )
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         )),
//                         Row(
//                           // crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pop(context);
//
//                               },
//                               child: Container(
//                                 width: 40.w,
//                                 height: 5.h,
//                                 // padding: const EdgeInsets.all(16.0),
//                                 decoration: BoxDecoration(
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(50)),
//                                   border: Border.all(
//                                       color: AppColors.buttonBackgroundColor),
//                                 ),
//                                 child: Center(
//                                   child: BoldTextWidget(
//                                     title: "Cancel",
//                                     fontsize: 12.sp,
//                                     fontcolor: AppColors.buttonBackgroundColor,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 2.w,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Utils().launchURL('${result.storeUrl}');
//                               },
//                               child: Container(
//                                 width: 40.w,
//                                 height: 5.h,
//
//                                 // padding: const EdgeInsets.all(16.0),
//                                 decoration: const BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(50)),
//                                   color: AppColors.buttonBackgroundColor,
//                                   // border: Border.all(),
//                                 ),
//                                 child: Center(
//                                   child: BoldTextWidget(
//                                     title: "Update",
//                                     fontsize: 12.sp,
//                                     fontcolor: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       });
//     } catch (e) {}
//   }
//
//   String getImagePath(String code) {
//     if (code == INSTITUTE_DIET) {
//       return 'assets/images/ic_du_launcher_round.png';
//     } else if (code == INSTITUTE_BU) {
//       return 'assets/images/ic_bhaikaka_launcher_round.png';
//     } else if (code == INSTITUTE_DSI) {
//       return 'assets/images/ic_dsi_launcher_round.png';
//     } else if (code == INSTITUTE_SMVIT) {
//       return 'assets/images/ic_smvit_launcher_round.png';
//     } else if (code == INSTITUTE_BMSIT) {
//       return 'assets/images/ic_bms_launcherround.png';
//     } else if (code == INSTITUTE_BMSIT) {
//       return 'assets/images/ic_bms_launcherround.png';
//     } else if (code == INSTITUTE_PAU) {
//       return 'assets/images/ic_pu_launcher_round.png';
//     } else if (code == INSTITUTE_KKS) {
//       return 'assets/images/ic_kks_launcher_round.png';
//     } else if (code == INSTITUTE_RAI) {
//       return 'assets/images/ic_rai_launcher.png';
//     } else {
//       return 'assets/images/ic_launcher_round.png';
//     }
//   }
//
//   Future<void> getAppInfo() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     String packageName = packageInfo.packageName;
//     String appSize = '';
//     String downloader = '';
//     try {
//       var response = await http.get(Uri.parse(
//         'https://play.google.com/store/apps/details?id=$packageName&hl=en-IN',
//         // https://play.google.com/store/apps/details?id=com.gnums.admission_crm&hl=en-IN
//       ));
//
//       if (response.statusCode == 200) {
//         var document = parse(response.body);
//         var scripts = document.querySelectorAll('script');
//         String scriptContent = '';
//
//         for (var script in scripts) {
//           var content = script.text;
//           if (content.contains('AF_initDataCallback')) {
//             scriptContent = content;
//             break;
//           }
//         }
//         var regex = RegExp(r'(?<=AF_initDataCallback\({).*?(?=\);})');
//         var match = regex.firstMatch(scriptContent);
//
//         if (match != null) {
//           var jsonString = '{${match.group(0)}}';
//           var data = jsonDecode(jsonString) as Map<String, dynamic>;
//           appSize = data['ds:8'] ?? '';
//           downloader = data['ds:13']['ds:1'][0] ?? '';
//         }
//       }
//     } catch (e) {}
//
//   }
//
//   void fetchAppDetails() async {
//
//     String appId = 'com.gnums.gnums'; // Replace with the actual app package name
//     var appDetails = await GooglePlayScraper().app(appId: appId);
//   }
//
//   // Future<void> fetchAppReviews() async {
//   //   final appId = 'com.example.app'; // Replace with the desired app's package name
//   //   final reviews = await GooglePlayScraper.getAppReviews(appId);
//   //   // Process the reviews as needed
//   //   for (var review in reviews) {
//   //     // ...
//   //   }
//   // }
//
//
// }
