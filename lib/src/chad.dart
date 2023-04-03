import 'package:dart_openai/openai.dart';

class Chad {
  Chad(String openAiApiKey, {String? openAiApiUrl}) {
    OpenAI.apiKey = openAiApiKey;

    if (openAiApiUrl != null) {
      OpenAI.baseUrl = openAiApiUrl;
    }
  }

  Stream<String> ask(String query) {
    return OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: query,
          role: OpenAIChatMessageRole.user,
        )
        ])
        .map((i) => i.choices.map((e) => e.delta.content).join())
        .where((i) => i != "null");
  }
}
