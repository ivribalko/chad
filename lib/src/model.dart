import 'package:get/get.dart';

class Model extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    count.listen((v) => Get.log('$v'));
  }

  @override
  void onClose() {
    count.close();
    super.onClose();
  }
}
