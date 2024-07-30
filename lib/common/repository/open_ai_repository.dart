import 'package:dart_openai/dart_openai.dart';

import '../utils.dart';

class OpenAiRepository {
  OpenAiRepository();

  Future<OpenAIChatCompletionModel> initChat({required String question, required String selectedProvider}) async {
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "answer user's question",
        ),
      ],
      role: OpenAIChatMessageRole.assistant,
    );
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(question),
      ],
      role: OpenAIChatMessageRole.user,
    );

    final requestMessages = [systemMessage, userMessage];

    final OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
      model: handleProviderModel(selectedProvider),
      messages: selectedProvider == 'Groq' ? [userMessage] : requestMessages,

      maxTokens: 200,
    );

    return chatCompletion;
  }
}
