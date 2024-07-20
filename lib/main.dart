import 'package:firebase_core/firebase_core.dart';
import 'package:royal_class_app/screens/categories_page.dart';
import 'package:royal_class_app/screens/login_sign_up/login_or_register_page.dart';
import 'package:royal_class_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_class_app/utils/preference_man.dart';
import 'api/api_service.dart';

PreferenceMan preferenceMan = PreferenceMan();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await preferenceMan.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ApiService.create());
    return Builder(
      builder: (context) => GetMaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: AppColors.PrimaryColor,
            unselectedWidgetColor: Colors.black,
            useMaterial3: false,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: const Color.fromARGB(255, 63, 81, 181))
                .copyWith(surface: Colors.white)),
        home: preferenceMan.isUserLogin() == true
            ? CategotiesPage()
            : LoginOrRegisterPage(),
      ),
    );
  }
}
