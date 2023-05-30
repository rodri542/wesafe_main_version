import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/change_password.dart';
import 'package:wesafe_main_version/pages/login/reset_password.dart';
import 'package:wesafe_main_version/pages/menu/add_contact_page.dart';
import 'package:wesafe_main_version/pages/menu/add_profile_image.dart';
import 'package:wesafe_main_version/pages/menu/config_page.dart';
import 'package:wesafe_main_version/pages/menu/contacts_page.dart';
import 'package:wesafe_main_version/pages/menu/delete_account.dart';
import 'package:wesafe_main_version/pages/menu/historial_page.dart';
import 'package:wesafe_main_version/pages/menu/main_menu_page.dart';
import 'package:wesafe_main_version/pages/menu/profile_page.dart';
import 'package:wesafe_main_version/pages/menu/verify_account.dart';
import 'package:wesafe_main_version/routes/routes.dart';
import 'package:wesafe_main_version/pages/login/sing_up_page.dart';

import '../pages/login/get_reset_code.dart';
import '../pages/login/login_page.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.singUpPage: (_) => const SingUpPage(),
    Routes.loginPage: (_) => const LoginPage(),
    Routes.mainPage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return MainMenuPage(
        getting: getting,
      );
    },
    Routes.resetPassword: (_) => const ResetPasswordPage(),
    Routes.configPage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return ConfigurationPage(
        getting: getting,
      );
    },
    Routes.contactsPage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return ContactsPage(
        getting: getting,
      );
    },
    Routes.historialPage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return HistorialPage(
        getting: getting,
      );
    },
    Routes.profilePage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return ProfilePage(
        getting: getting,
      );
    },
    Routes.addContactPage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return AddContactPage(
        getting: getting,
      );
    },
    Routes.deleteAccountPage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return DeleteAcountPage(
        getting: getting,
      );
    },
    Routes.verifyAccountPage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return VerifyAccountPage(
        getting: getting,
      );
    },
    Routes.getResetCode: (context) {
      final Map<String, dynamic> data =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      final int numero = data['numero'] as int;
      final String email = data['email'] as String;
      return GetResetCodePage(
        number: numero,
        email: email,
      );
    },
    Routes.changePasswordPage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return ChangePasswordPage(
        getting: getting,
      );
    },
    Routes.addProfileImage: (context) {
      final getting = ModalRoute.of(context)?.settings.arguments;
      return ProfileImagePage(
        getting: getting,
      );
    },
  };
}
