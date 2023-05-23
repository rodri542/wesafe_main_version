import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wesafe_main_version/routes/app_routes.dart';
import 'package:wesafe_main_version/pages/login/login_page.dart';
import 'package:wesafe_main_version/utils/material_color_generator.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return const MyApp();
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('es'),
          Locale('en'),
        ],
        routes: appRoutes,
        title: 'weSafe',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
            color: Color(0xffB17A50),
          )),
          fontFamily: 'FuenteWeSafe',
          primarySwatch: generateMaterialColor(
            const Color(0xff511262),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
