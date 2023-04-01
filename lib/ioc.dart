import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/common.dart';
import 'src/chad.dart';

class IoC {
  static Future init() async {
    await dotenv.load();
    await GetStorage.init(kSave);

    Get.put(Chad(dotenv.env['OPEN_AI_API_KEY']!));
  }
}
