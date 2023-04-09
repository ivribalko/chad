import 'dart:math';

import 'package:dart_openai/openai.dart';
import 'package:get/get.dart';

import 'lookup.dart';

class Chad {
  final list = RxList<Lookup>();

  final int _tokens;
  final _words = RegExp("[\\w-]+");
  final _custom = [
    'be concise',
    'do not apologize',
    'assign d to mean define',
  ].map(
    (e) => OpenAIChatCompletionChoiceMessageModel(
      content: e,
      role: OpenAIChatMessageRole.system,
    ),
  );

  Chad(String openAiApiKey, this._tokens) {
    OpenAI.apiKey = openAiApiKey;
  }

  void ask(String query) {
    var lookup = Lookup(query);

    list.add(lookup);

    var last = list.reversed
        .where((i) => i.chad != null)
        .take(10)
        .fold<List<OpenAIChatCompletionChoiceMessageModel>>(
            [lookup.user],
            (it, i) => it
              ..add(i.chad!)
              ..add(i.user));

    var words = 0;

    OpenAI.instance.chat
        .createStream(
            model: "gpt-3.5-turbo",
            messages: (last..insertAll(min(last.length, 3), _custom))
                .takeWhile((i) => (words = words + wordCount(i)) <= _tokens)
                .toList()
                .reversed
                .toList())
        .map((i) => i.choices.map((e) => e.delta.content).join())
        .where((i) => i != "null")
        .listen(
          lookup.reply.add,
          onDone: lookup.done,
        );
  }

  int wordCount(OpenAIChatCompletionChoiceMessageModel i) {
    return _words.allMatches(i.content).length;
  }
}
