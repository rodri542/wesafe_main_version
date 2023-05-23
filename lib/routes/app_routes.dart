import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/reset_password.dart';
import 'package:wesafe_main_version/pages/menu/add_contact_page.dart';
import 'package:wesafe_main_version/pages/menu/config_page.dart';
import 'package:wesafe_main_version/pages/menu/contacts_page.dart';
import 'package:wesafe_main_version/pages/menu/historial_page.dart';
import 'package:wesafe_main_version/pages/menu/main_menu_page.dart';
import 'package:wesafe_main_version/pages/menu/profile_page.dart';
import 'package:wesafe_main_version/routes/routes.dart';
import 'package:wesafe_main_version/pages/login/sing_up_page.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.singUpPage: (_) => const SingUpPage(),
    Routes.mainPage: (_) => const MainMenuPage(),
    Routes.resetPassword: (_) => const ResetPasswordPage(),
    Routes.configPage: (_) => const ConfigurationPage(),
    Routes.contactsPage: (_) => const ContactsPage(),
    Routes.historialPage: (_) => const HistorialPage(),
    Routes.profilePage: (_) => const ProfilePage(),
    Routes.addContactPage: (_) => const AddContactPage(),
  };
}
