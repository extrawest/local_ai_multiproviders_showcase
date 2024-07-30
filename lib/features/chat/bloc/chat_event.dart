part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();
}


class SendMessage extends ChatEvent {
  final String request;
  final String selectedProvider;

  const SendMessage({required this.request, required this.selectedProvider});

  @override
  List<Object> get props => [request, selectedProvider];
}


class AddMessage extends ChatEvent {
  final List<ChatEvent> messages;
  const AddMessage([this.messages = const []]);
  @override
  List<Object> get props => [messages];
}
