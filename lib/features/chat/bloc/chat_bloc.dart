import 'package:dart_openai/dart_openai.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/repository/open_ai_repository.dart';
import '../screens/chat_screen.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final OpenAiRepository openAiRepository;

  ChatBloc(this.openAiRepository) : super(const MessageInitial([])) {
    on<SendMessage>(_onSendMessage);
    final List<MessageModel> initMessage = [MessageModel(message: 'Assistant: How can I help you?', isUserMessage: false)];
    emit(MessageAdded(initMessage));
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {

      // Add user message to state.messages
      final userMessagesList = List<MessageModel>.from(state.messages)..add(MessageModel(message: 'User: ${event.request}', isUserMessage: true));
      emit(MessageAdded(userMessagesList));
      emit(MessageLoading(state.messages));

      OpenAIChatCompletionModel chatCompletion = await openAiRepository.initChat( event.request);

      // Add assistant message to state.messages
      final updatedMessages = List<MessageModel>.from(userMessagesList)..add(MessageModel(message: 'Assistant: ${chatCompletion.choices.first.message.content!.first.text!}', isUserMessage: false));
      emit(MessageAdded(updatedMessages));
    } catch (e) {
      emit(MessageError(e.toString(), state.messages));
    }
  }
}



// import 'package:dart_openai/dart_openai.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../common/repository/open_ai_repository.dart';
// import '../chat_screen.dart';
//
// part 'chat_event.dart';
// part 'chat_state.dart';
//
// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final OpenAiRepository openAiRepository;
//
//   ChatBloc(this.openAiRepository) : super(const MessageInitial([])) {
//     on<SendMessage>(_onSendMessage);
//     final List<MessageModel> initMessage = [MessageModel(message: 'Assistant: How can I help you?', isUserMessage: false)];
//     emit(MessageAdded(initMessage));
//   }
//
//   Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
//     try {
//       // Add user message to state.messages
//       final userMessagesList = List<MessageModel>.from(state.messages)
//         ..add(MessageModel(message: 'User: ${event.request}', isUserMessage: true));
//       emit(MessageAdded(userMessagesList));
//       emit(MessageLoading(state.messages));
//
//
//
//       OpenAIChatCompletionModel chatCompletion = await openAiRepository.initChat(
//
//
//       );
//
//       // Add assistant message to state.messages
//       final updatedMessages = List<MessageModel>.from(userMessagesList)
//         ..add(MessageModel(message: 'Assistant: ${chatCompletion.choices.first.message}', isUserMessage: false));
//       emit(MessageAdded(updatedMessages));
//     } catch (e) {
//       emit(MessageError(e.toString(), state.messages));
//     }
//   }
// }