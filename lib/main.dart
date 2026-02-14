import 'package:flutter/widgets.dart';
import 'package:telemedicina_app/core/_export.dart';
import 'package:telemedicina_app/telemedicina_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initInjector();
  runApp(const TelemedicinaApp());
}
