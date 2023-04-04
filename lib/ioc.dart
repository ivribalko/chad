import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/common.dart';
import 'src/chad.dart';

class IoC {
  static Future init() async {
    await GetStorage.init(kSave);
    await dotenv.load(fileName: 'env');

    var api = Chad(dotenv.env['OPENAI_API_KEY']!);
    api.ask('be super concise');
    Get.put(api);
  }
}
