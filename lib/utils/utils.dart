// import 'dart:convert';
// import 'dart:io';
//
// import 'package:app_icon_switcher/app_icon_switcher.dart';
// import 'package:flutter/material.dart';
// import 'package:gnums/model/app_registration_model/app_registration_model.dart';
// import 'package:gnums/utils/preference_man.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../main.dart';
// import '../model/lms_dashboard_model/lms_subject_wise_summary_model.dart';
// import '../screens/webview/web_view_page.dart';
//
// class Utils {
//   bool isValieMobile(String value) {
//     return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value);
//   }
//
//   String getCurrencyFormated(amount) {
//     return NumberFormat.decimalPattern('hi').format(amount);
//   }
//
//   String getFormatedDateSMSLOGMMYYYY(dateToFormat) {
//     return DateFormat("MMMM yyyy").format(
//         DateFormat("yyyy-MM-ddThh:mm:ss").parse(dateToFormat.toString()));
//   }
//
//   String getFormatedDateSMSLOGDDMM(dateToFormat) {
//     return DateFormat("dd MMMM").format(
//         DateFormat("yyyy-MM-ddThh:mm:ss").parse(dateToFormat.toString()));
//   }
//
//   String getFormatedDateForEvent(dateToFormat,
//       {String? otherCondiation, String? otherString}) {
//     return DateFormat("dd${otherCondiation ?? " "}MMM ${otherString ?? ""}")
//         .format(DateFormat("yyyy-MM-dd hh:mm:ss")
//             .parse(dateToFormat.toString().replaceAll("T", " ")));
//   }
//
//   String getFromDateToDateForEvent({
//     required String fromDate,
//     required String toDate,
//   }) {
//     return '${DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(fromDate.toString().replaceAll("T", " ")))} To ${DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(toDate.toString().replaceAll("T", " ")))}';
//   }
//
//   String getFormatedDateDDMMYYYY(dateToFormat) {
//     return DateFormat("dd-MM-yyyy").format(
//         DateFormat("yyyy-MM-ddThh:mm:ss").parse(dateToFormat.toString()));
//   }
//
//   String getFormatedTimeHHMM(timeToFormat) {
//     return DateFormat("hh:mm a").format(
//         DateFormat("yyyy-MM-ddThh:mm:ss").parse(timeToFormat.toString()));
//   }
//
//   String getFormatedTimeDay(timeToFormat) {
//     return DateFormat("E").format(
//         DateFormat("yyyy-MM-ddThh:mm:ss").parse(timeToFormat.toString()));
//   }
//
//   String getFormatedDateDD(dateToFormat) {
//     return DateFormat("dd").format(
//         DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateToFormat.toString()));
//   }
//
//   DateTime getFormatedWeekDate(DateTime dateTime, int dayNo) {
//     return dateTime.subtract(Duration(days: dateTime.weekday - dayNo));
//   }
//
//   String getFormatedDateY(dateToFormat) {
//     return DateFormat("dd-MM-yyyy").format(
//         DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateToFormat.toString()));
//   }
//
//   String getFormatedDateDDMMYYYYT(dateToFormat) {
//     return DateFormat("dd-MM-yyyy").format(
//         DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateToFormat.toString()));
//   }
//
//   Future<String> checkAndUpdateApplication() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     String version = packageInfo.version;
//     String buildNumber = packageInfo.buildNumber;
//     return '${version}(${buildNumber})';
//   }
//
//   DateTime joinDateTime({
//     required DateTime date,
//     required TimeOfDay time,
//   }) {
//     return new DateTime(
//       date.year,
//       date.month,
//       date.day,
//       time.hour,
//       time.minute,
//     );
//   }
//
//   TimeOfDay stringToTimeOfDay(String time) {
//     // Parse the string into a DateTime object
//     DateFormat format = DateFormat.jm(); // 'jm' format for "10:30 AM"
//     DateTime dateTime = format.parse(time);
//
//     // Create a TimeOfDay object from the DateTime
//
//     return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
//
//   }
//
//   // void launchWebURL(context, String _url, String? _appBarTitle) async {
//   //   if (await Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) =>
//   //           CustomWebViewer(url: _url, appBarTitle: _appBarTitle),
//   //     ),
//   //   )) throw 'Could not launch $_url';
//   // }
//   void launchWebURL(
//     context,
//     String _url,
//     String? _appBarTitle,
//   ) async {
//     try {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               FileUploadWebViewer(url: _url, appBarTitle: _appBarTitle),
//         ),
//       );
//     } catch (e) {
//       throw 'Could not launch $_url';
//     }
//   }
//
//   void launchURL(String _url) async {
//     if (!await launch(_url)) throw 'Could not launch $_url';
//   }
//
//   void launchCallUrl(String _url) async {
//     var phoneCall = await Uri.parse("tel:$_url");
//     if (await launchUrl(phoneCall)) throw 'Could not launch $_url';
//   }
//
//   void launchMailUrl(String _url) async {
//     var mail = Uri.parse("mailto:$_url");
//     if (await launchUrl(mail)) throw 'Could not launch $_url';
//   }
//
//   void replaceIcon(String CODE) {
//     Platform.isAndroid
//         ? AppIconSwitcher.updateIcon(CODE == "LOC" ? "LOC" : CODE.toString())
//         : null;
//   }
//
//   void LmsDetails(subjectwiselist resultList) async {
//     preferenceMan.setLmsSubjectID(resultList.lMSSeasonID.toString());
//     preferenceMan.setLmssem(resultList.semester1.toString());
//   }
//
//   static Future<File> byteCodeToPdfConverter({
//     required String byteCode,
//     required String fileName,
//   }) async {
//     String bytes = byteCode;
//     var base64String = base64Decode(bytes.replaceAll('\n', ''));
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/$fileName.pdf");
//     await file.writeAsBytes(base64String.buffer.asUint8List());
//     return file;
//   }
//
//   static Future openFile(File file) async {
//     final url = file.path;
//     await OpenFile.open(url);
//   }
//
//   void setUserLogin(AppRegistrationItem resultList, PreferenceMan preferenceMan,
//       bool isCodeVerification) async {
//     print('resultList.IsStudentMentoring::::${resultList.IsStudentMentoring}');
//     preferenceMan.setFullName(resultList.studentFullName.toString());
//     preferenceMan.setPhotoPath(resultList.photoPath.toString());
//     preferenceMan.setEnrollmentNo(resultList.enrollmentNo.toString());
//
//     preferenceMan.setStudentStatusName(resultList.studentStatusName.toString());
//     preferenceMan.setCurrentDivision(resultList.currentDivision.toString());
//     preferenceMan.setCurrentSemester(resultList.currentSemester as int);
//     preferenceMan.setCourseName(resultList.courseName.toString());
//     preferenceMan.setMobileSessionID(resultList.mobileSessionID.toString());
//     preferenceMan.setFatherMobile(resultList.fatherMobile.toString());
//     preferenceMan.setEmail(resultList.email.toString());
//     preferenceMan.setPhoneStudent1(resultList.phoneStudent1.toString());
//     preferenceMan.setStudentUserID(
//         resultList.studentUserID != null ? resultList.studentUserID as int : 0);
//     preferenceMan.setHosRegistrationID(resultList.hosRegistrationID != null
//         ? resultList.hosRegistrationID as int
//         : 0);
//     preferenceMan
//         .setBedID(resultList.bedID != null ? resultList.bedID as int : 0);
//     preferenceMan
//         .setSpecializationName(resultList.specializationName.toString());
//     preferenceMan.setStudentID(resultList.studentID as int);
//     preferenceMan.setCurrentRollNo(
//         resultList.currentRollNo != null ? resultList.currentRollNo as int : 0);
//     preferenceMan.setIsAcademicCalender(resultList.isAcademicCalender as int);
//     preferenceMan.setUniversityName(resultList.universityName.toString());
//     preferenceMan.setInstituteFullName(resultList.aPPInstituteName.toString());
//     preferenceMan.setIsAttendance(resultList.isAttendance as int);
//     preferenceMan.setIsFee(resultList.isFee as int);
//     preferenceMan.setIsHostel(resultList.isHostel as int);
//     preferenceMan.setIsOtherFee(resultList.isOtherFee as int);
//     preferenceMan.setIsProfile(resultList.isProfile as int);
//     preferenceMan.setIsResult(resultList.isResult as int);
//     preferenceMan
//         .setIsPlacementattendance(resultList.isStudentPlacement as int);
//     preferenceMan.setIsMentoring(resultList.IsStudentMentoring != null
//         ? resultList.IsStudentMentoring as int
//         : 0);
//     preferenceMan.setIsPunishment(resultList.IsStudentPunishment != null
//         ? resultList.IsStudentPunishment as int
//         : 0);
//     preferenceMan.setCourseID(resultList.courseID as int);
//     preferenceMan.setIsTimeTable(resultList.isTimeTable as int);
//     preferenceMan.setIsTranscript(resultList.isTranscript as int);
//     preferenceMan.setIsTransport(resultList.isTransport as int);
//     preferenceMan.setIsIA(resultList.isInternalAssessment as int);
//     preferenceMan.setIsFeedback(resultList.isFeedback as int);
//     preferenceMan.setHeaderText_Sem(resultList.headerTextSem.toString());
//     preferenceMan.setWebLoginURL(resultList.webLoginURL.toString());
//     preferenceMan.setFeePaymentURL(resultList.feePaymentURL.toString());
//     preferenceMan.setTransportRegistrationURL(
//         resultList.transportRegistrationURL.toString());
//     preferenceMan.setIsWebLoginAllowed(resultList.isWebLoginAllowed as int);
//     preferenceMan.setIsFeePaymentAllowed(resultList.isFeePaymentAllowed as int);
//     preferenceMan.setIsTransportRegistrationAllowed(
//         resultList.isTransportRegistrationAllowed as int);
//     preferenceMan.setIsLMSAllowed(resultList.isLMSAllowed as int);
//     preferenceMan
//         .setIsNotificationAllowed(resultList.isNotificationAllowed as int);
//     preferenceMan.setIsStudentSMSLog(resultList.isStudentSMSLog as int);
//
//     preferenceMan.setIsStudentCretificateRequest(
//         resultList.isStudentCretificateRequest != null
//             ? resultList.isStudentCretificateRequest as int
//             : 0);
//
//     preferenceMan.setIsStudentGrievanceRegistration(
//         resultList.isStudentGrievanceRegistration != null
//             ? resultList.isStudentGrievanceRegistration as int
//             : 0);
//
//     preferenceMan.setIsStudentDataChangeRequest(
//         resultList.isStudentDataChangeRequest != null
//             ? resultList.isStudentDataChangeRequest as int
//             : 0);
//
//     preferenceMan.setIsStudentSupplementaryExamFormFilling(
//         resultList.isStudentSupplementaryExamFormFilling != null
//             ? resultList.isStudentSupplementaryExamFormFilling as int
//             : 0);
//
//     preferenceMan.setIsStudentOldExamPaper(
//         resultList.isStudentOldExamPaper != null
//             ? resultList.isStudentOldExamPaper as int
//             : 0);
//
//     preferenceMan.setIsLmsMarks(resultList.isStudentLMSTestResult as int);
//     preferenceMan.setIsStudentEventDashboard(
//       resultList.isStudentEventDashboard != null
//           ? resultList.isStudentEventDashboard as int
//           : 0,
//     );
//     preferenceMan.setIsStudentAnnouncement(
//       resultList.isStudentAnnouncement != null
//           ? resultList.isStudentAnnouncement as int
//           : 0,
//     );
//     preferenceMan.setStudentCertificateRequestURL(
//       resultList.studentCertificateRequestURL.toString(),
//     );
//
//     preferenceMan.setStudentGrievanceURL(
//       resultList.studentGrievanceURL.toString(),
//     );
//     preferenceMan.setStudentDataChangeRequestListForStudentURL(
//       resultList.studentDataChangeRequestListForStudentURL.toString(),
//     );
//     preferenceMan.setStudentSupplementaryExamFormFillingURL(
//       resultList.studentSupplementaryExamFormFillingURL.toString(),
//     );
//     preferenceMan.setStudentOldExamPaperURL(
//       resultList.studentOldExamPaperURL.toString(),
//     );
//
//     preferenceMan.setTransportRegistrationURL(
//         resultList.transportRegistrationURL.toString());
//     preferenceMan.setLMSURL(resultList.lmsurl.toString());
//     preferenceMan.setGuardianEmail(resultList.guardianEmail.toString());
//     preferenceMan.setGuardianMobile(resultList.guardianMobile.toString());
//     preferenceMan.setMotherEmail(resultList.motherEmail.toString());
//     preferenceMan.setMotherMobile(resultList.motherMobile.toString());
//     preferenceMan.setFatherEmail(resultList.fatherEmail.toString());
//     preferenceMan.setFatherMobile(resultList.fatherMobile.toString());
//     preferenceMan.setPhoneStudent2(resultList.phoneStudent2.toString());
//     preferenceMan.setPermanentAddress(resultList.permanentAddress.toString());
//     preferenceMan.setCurrentBatch(resultList.currentBatch.toString());
//     preferenceMan.setProgramName(resultList.programName.toString());
//     preferenceMan.setInstituteName(resultList.instituteName.toString());
//     preferenceMan.setFieldDisplayName_EnrollmentNo(
//         resultList.fieldDisplayNameEnrollmentNo.toString());
//     preferenceMan.setFieldDisplayName_SpecializationName(
//         resultList.fieldDisplayNameSpecializationName.toString());
//     preferenceMan.setFieldDisplayName_DivisionName(
//         resultList.fieldDisplayNameDivisionName.toString());
//     preferenceMan.setFieldDisplayName_RollNo(
//         resultList.fieldDisplayNameRollNo.toString());
//     preferenceMan.setFieldDisplayName_AdmissionCategoryName(
//         resultList.fieldDisplayNameAdmissionCategoryName.toString());
//     preferenceMan.setFieldDisplayName_HostelPersonName(
//         resultList.fieldDisplayNameHostelPersonName.toString());
//     preferenceMan.setFieldDisplayName_ResourceName(
//         resultList.fieldDisplayNameResourceName.toString());
//     preferenceMan.setFieldDisplayName_RectorName(
//         resultList.fieldDisplayNameRectorName.toString());
//     preferenceMan
//         .setFieldDisplayName_Lab(resultList.fieldDisplayNameLab.toString());
//     preferenceMan.setFieldDisplayName_Lecture(
//         resultList.fieldDisplayNameLecture.toString());
//     preferenceMan.setFieldDisplayName_Program(
//         resultList.fieldDisplayNameProgram.toString());
//     preferenceMan.setFieldDisplayName_Subject(
//         resultList.fieldDisplayNameSubject.toString());
//
//     //Mentor
//     preferenceMan.setFieldDisplayName_mentorStaffFullName(
//         resultList.mentorStaffFullName.toString());
//
//     preferenceMan.setFieldDisplayName_mentorrStaffEmailInstitute(
//         resultList.mentorStaffEmailInstitute.toString());
//
//     preferenceMan.setnextMeetingDate(resultList.nextMeetingDate.toString());
//
//     preferenceMan.setFieldDisplayName_mentorStaffMobile(
//         resultList.mentorStaffMobile.toString());
//     preferenceMan
//         .setIsStudentExamSchedule(resultList.isStudentExamSchedule as int);
//     preferenceMan.setIsStudentQRCodeForAttendance(
//         resultList.isStudentQRCodeForAttendance != null
//             ? resultList.isStudentQRCodeForAttendance as int
//             : 0);
//     preferenceMan.setAdmissionApplicationNo(
//         resultList.admissionApplicationNo.toString());
//     preferenceMan
//         .setAdmissionAcademicYear(resultList.admissionAcademicYear.toString());
//     preferenceMan.setBloodGroup(resultList.bloodGroup.toString());
//     preferenceMan.setBirthDate1(resultList.birthDate1.toString());
//     preferenceMan
//         .setEmergencyContactNo(resultList.emergencyContactNo.toString());
//     if (isCodeVerification) {
//       preferenceMan.setInstituteCode(resultList.instituteCode.toString());
//       preferenceMan.setBG_PATH(resultList.bGPath.toString());
//       preferenceMan.setLogoPath(resultList.logoPath.toString());
//     }
//   }
//
//   String timeDiffrenceForNotification({
//     required DateTime FromTime,
//     required DateTime toTime,
//   }) {
//     num timeDiffrenceInMinutes = toTime.difference(FromTime).inMinutes;
//     if (timeDiffrenceInMinutes < 60) {
//       return '${timeDiffrenceInMinutes} min';
//     } else if (timeDiffrenceInMinutes < 1440) {
//       return '${toTime.difference(FromTime).inHours} hr';
//     } else {
//       return '${toTime.difference(FromTime).inDays} dy';
//     }
//   }
// }