import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/repository/open_ai_repository.dart';
import '../../models/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final OpenAiRepository openAiRepository;

  ChatBloc(this.openAiRepository) : super(const MessageInitial([])) {
    on<SendMessage>(_onSendMessage);
    add(const SendMessage(request: '', selectedProvider: ''));
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      if (event.request.isEmpty && event.selectedProvider.isEmpty) {
        // Initial state emission
        final List<MessageModel> initMessage = [MessageModel(message: 'Assistant: How can I help you?', isUserMessage: false)];
        emit(MessageAdded(initMessage));
        return;
      }
      log('event.selectedProvider>>> ${event.selectedProvider}');
      // Add user message to state.messages
      final userMessagesList = List<MessageModel>.from(state.messages)..add(MessageModel(message: 'User: ${event.request}', isUserMessage: true));
      emit(MessageAdded(userMessagesList));
      emit(MessageLoading(state.messages));
      final OpenAIChatCompletionModel chatCompletion = await openAiRepository.initChat(question: event.request, selectedProvider: event.selectedProvider);
      // Add assistant message to state.messages
      final updatedMessages = List<MessageModel>.from(userMessagesList)..add(MessageModel(message: 'Assistant: ${chatCompletion.choices.first.message.content!.first.text!}', isUserMessage: false));
      emit(MessageAdded(updatedMessages));
    } catch (e) {
      emit(MessageError(e.toString(), state.messages));
    }
  }
}
