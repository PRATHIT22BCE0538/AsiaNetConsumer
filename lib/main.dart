import 'package:asianetconsumer/Utility/color_constants.dart';
import 'package:asianetconsumer/routes/app_pages.dart';
import 'package:asianetconsumer/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

void main() {
  runApp(const MyAppAsia());
}


class MyAppAsia extends StatefulWidget {
  const MyAppAsia({super.key});

  @override
  State<MyAppAsia> createState() => _MyAppState();
}

class _MyAppState extends State<MyAppAsia> with WidgetsBindingObserver {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            primaryColor: primaryColor,
            useMaterial3: false
        ),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        getPages: AppPages.routes,
        initialRoute: Routes.onboarding,
        defaultTransition: Transition.cupertino,
      ),
    );
  }
}
