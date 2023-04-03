import 'package:get/get.dart';
import 'package:chad/src/chad.dart';

class Lookup {
  final String input;
  final reply = RxList<String>();

  Lookup(this.input) {
    Get.find<Chad>().ask(input).listen(reply.add);
  }
}
