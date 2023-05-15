import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/reset_password.dart';
import 'package:wesafe_main_version/pages/menu/main_menu_page.dart';
import 'package:wesafe_main_version/routes/routes.dart';
import 'package:wesafe_main_version/pages/login/sing_up_page.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.singUpPage: (_) => const SingUpPage(),
    Routes.mainPage: (_) => const MainMenuPage(),
    Routes.resetPassword: (_) => const ResetPasswordPage(),
  };
}
