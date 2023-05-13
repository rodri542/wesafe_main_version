import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/login_page.dart';
import 'package:wesafe_main_version/pages/login/main_menu_page.dart';
import 'package:wesafe_main_version/utils/material_color_generator.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'weSafe',
        theme: ThemeData(
          fontFamily: 'FuenteWeSafe',
          primarySwatch: generateMaterialColor(
            Color(0xff511262),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
