import 'package:get/get.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';
import 'package:telemedicina_app/features/authentication/presentation/bindings/auth_binding.dart';
import 'package:telemedicina_app/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:telemedicina_app/features/authentication/presentation/pages/login_page.dart';
import 'package:telemedicina_app/features/authentication/presentation/pages/register_page.dart';
import 'package:telemedicina_app/features/authentication/presentation/pages/welcome_page.dart';
import 'package:telemedicina_app/features/symptoms/_export.dart';
import 'package:telemedicina_app/features/video_call/_export.dart';
import 'package:telemedicina_app/features/vital_signs/_export.dart';

class AppPages {
  static const initial = Routes.welcome;

  static final pages = <GetPage<void>>[
    GetPage<void>(name: Routes.welcome, page: () => const WelcomePage()),
    GetPage<void>(
      name: Routes.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage<void>(name: Routes.register, page: () => const RegisterPage()),
    GetPage<void>(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage<void>(
      name: Routes.home,
      page: () => const SymptomsPage(),
      binding: SymptomsBinding(),
    ),
    GetPage<void>(
      name: Routes.vitalSignsCapture,
      page: () => const VitalSignsCapturePage(),
    ),
    GetPage<void>(name: Routes.videoCall, page: () => const VideoCallPage()),
  ];
}
