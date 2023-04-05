import 'package:dart_openai/openai.dart';
import 'package:get/get.dart';

class Lookup {
  final reply = RxList<String>();

  late final OpenAIChatCompletionChoiceMessageModel user;

  String get query => user.content;

  OpenAIChatCompletionChoiceMessageModel? _chad;
  OpenAIChatCompletionChoiceMessageModel? get chad =>
      _chad ??
      (reply.isEmpty
          ? null
          : OpenAIChatCompletionChoiceMessageModel(
              content: reply.join(),
              role: OpenAIChatMessageRole.assistant,
            ));

  void done() {
    _chad = OpenAIChatCompletionChoiceMessageModel(
      content: reply.join(),
      role: OpenAIChatMessageRole.assistant,
    );
  }

  Lookup(String query) {
    user = OpenAIChatCompletionChoiceMessageModel(
      content: query,
      role: OpenAIChatMessageRole.user,
    );
  }
}
