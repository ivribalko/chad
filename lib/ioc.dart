import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/common.dart';
import 'src/model.dart';
import 'ui/common.dart';

class IoC {
  static Future init() async {
    await GetStorage.init(kSave);

    GetStorage(kSave).listenKey(
      kDarkMode,
      setThemeMode,
    );

    Get.put(Model());
  }
}

void setThemeMode(x) {
  Get.changeThemeMode(
    getThemeMode(
      GetStorage(kSave),
    ),
  );
}
