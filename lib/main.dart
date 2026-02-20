import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:telemedicina_app/features/settings/_export.dart';
import 'package:telemedicina_app/telemedicina_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await GetStorage.init();
  await initializeSettingsFeature();

  runApp(const TelemedicinaApp());
}
