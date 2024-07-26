import 'package:dart_openai/dart_openai.dart';

class OpenAiRepository {
  OpenAiRepository();
  Future<OpenAIChatCompletionModel> initChat(String question) async {
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

    OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
      model: "",
      // model: "gpt-3.5-turbo",
      messages: requestMessages,
      maxTokens: 200,


    );

    return chatCompletion;
  }
}


