part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();
}


class SendMessage extends ChatEvent {
  final String request;

  const SendMessage(this.request);

  @override
  List<Object> get props => [request];
}


class AddMessage extends ChatEvent {
  final List<ChatEvent> messages;
  const AddMessage([this.messages = const []]);
  @override
  List<Object> get props => [messages];
}
